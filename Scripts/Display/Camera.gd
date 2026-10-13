extends Camera2D

@export var scrollStep: float = 60.0
@export var worldTop: float = 0.0
@export var worldBottom: float = 3240.0
@export var dragSensitivity: float = 1.0
@export var slideFriction: float = 2000.0
@export var slideMinSpeed: float = 40.0


var _dragging := false
var _mouseDragStart := Vector2.ZERO
var _cameraDragStart := Vector2.ZERO

var _sliding := false
var _velocity := Vector2.ZERO
var _prevPosition := Vector2.ZERO

func _ready() -> void:
	set_process(false)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					global_position.y -= scrollStep
				MOUSE_BUTTON_WHEEL_DOWN:
					global_position.y += scrollStep
					
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.is_pressed():
				_startDrag()
			else:
				_endDrag()
	
	elif event is InputEventMouseMotion and _dragging:
		var mousePos := get_viewport().get_mouse_position()
		var mouseDelta := mousePos -_mouseDragStart
		global_position.y = _cameraDragStart.y - mouseDelta.y * dragSensitivity	
	
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
	if abs(_velocity.y) > slideMinSpeed:
		_sliding = true
	else:
		_sliding = false
		set_process(false)

func _boundaryClamps() -> void:
	var _halfVP := get_viewport_rect().size * 0.5
	global_position.x = clampf(global_position.x, limit_left + _halfVP.x, limit_right - _halfVP.x)
	global_position.y = clampf(global_position.y, worldTop + _halfVP.y, worldBottom - _halfVP.y)
	
func _process(delta: float) -> void:
	if _dragging:
		_velocity = (global_position - _prevPosition) / delta
		_prevPosition = global_position
	elif _sliding:
		var intendedY := global_position.y + _velocity.y * delta
		global_position.y = intendedY
		_boundaryClamps()
		if not is_equal_approx(global_position.y, intendedY):
			_velocity.y = 0.0
		_velocity.y = move_toward(_velocity.y, 0.0, slideFriction * delta)
		if abs(_velocity.y) < slideMinSpeed:
			_velocity = Vector2.ZERO
			_sliding = false
			set_process(false)
