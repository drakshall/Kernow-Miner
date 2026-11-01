extends Camera2D

# Multiplicative zoom factor applied each scroll step.
@export var zoomStep: float = 1.1
# Upper clamp for multiplicative zoom factor.
@export var maxZoom: float = 4.0
# Multiplicative drag sensitivity applied on mouse-to-camera translation.
@export var dragSensitivity: float = 1.0
# Deceleration rate during camera slide in pixels/second^2.
@export var slideFriction: float = 2000.0
# Defines the velocity that must be exceeded for a drag to start and must be moved below the threshold to stop.
@export var slideMinSpeed: float = 40.0

var _dragging := false
var _mouseDragStart := Vector2.ZERO
var _cameraDragStart := Vector2.ZERO
var _minZoom: float = 0.1
var _sliding := false
var _velocity := Vector2.ZERO
var _prevPosition := Vector2.ZERO

# _process is enabled only when its in use for camera velocity/intertia, otherwise its kept disabled
func _ready() -> void:
	set_process(false)

# Handles otherwise unhandled inputs to avoid cases like scrolling in a menu also scrolling the map
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					_applyZoom(zoomStep)
				MOUSE_BUTTON_WHEEL_DOWN:
					_applyZoom(1.0 / zoomStep)
					
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.is_pressed():
				_startDrag()
			else:
				_endDrag()
	
	elif event is InputEventMouseMotion and _dragging:
		var mousePos := get_viewport().get_mouse_position()
		var mouseDelta := mousePos -_mouseDragStart
		global_position = _cameraDragStart - (mouseDelta / zoom) * dragSensitivity
		_boundaryClamps()

func _applyZoom(factor: float) -> void:
	var newZoom := clampf(zoom.x * factor, _minZoom, maxZoom)
	zoom = Vector2(newZoom, newZoom)
	_boundaryClamps()

func _startDrag() -> void:
	_dragging = true
	_sliding = false
	_velocity = Vector2.ZERO
	_mouseDragStart = get_viewport().get_mouse_position()
	_cameraDragStart = global_position
	_prevPosition = global_position
	set_process(true)
#
func _endDrag() -> void:
	_dragging = false
	if _velocity.length() > slideMinSpeed:
		_sliding = true
	else:
		_sliding = false
		set_process(false)

func _boundaryClamps() -> void:
	var _halfVP := get_viewport_rect().size * 0.5/zoom
	global_position.x = clampf(global_position.x, limit_left + _halfVP.x, limit_right - _halfVP.x)
	global_position.y = clampf(global_position.y, limit_top + _halfVP.y, limit_bottom - _halfVP.y)

func applyBounds(newSize: Vector2) -> void:
	limit_left = 0
	limit_top = 0
	limit_right = int(newSize.x)
	limit_bottom = int(newSize.y)
	
	var viewportWidth := get_viewport_rect().size.x
	_minZoom = min(1.0, viewportWidth / newSize.x)
	zoom = Vector2(max(zoom.x, _minZoom), max(zoom.y, _minZoom))
	_boundaryClamps()

func _process(delta: float) -> void:
	if _dragging:
		_velocity = (global_position - _prevPosition) / delta
		_prevPosition = global_position
		
	elif _sliding:
		var intended := global_position + _velocity * delta
		global_position = intended
		_boundaryClamps()
		
		if not is_equal_approx(global_position.y, intended.y):
			_velocity.y = 0.0
		if not is_equal_approx(global_position.x, intended.x):
			_velocity.x = 0.0
			
		_velocity = _velocity.move_toward(Vector2.ZERO, slideFriction * delta)
		
		if _velocity.length() < slideMinSpeed:
			_velocity = Vector2.ZERO
			_sliding = false
			set_process(false)
