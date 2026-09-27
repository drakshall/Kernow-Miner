extends Camera2D

@export var scrollStep: float = 60.0

var _dragging := false
var _dragStartMouse := Vector2.ZERO
var _dragStartCamera := Vector2.ZERO

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
				_dragging = true
				_dragStartMouse = get_viewport().get_mouse_position()
				_dragStartCamera = global_position
			else:
				_dragging = false
	
	elif event is InputEventMouseMotion and _dragging:
		var mousePos := get_viewport().get_mouse_position()
		global_position = _dragStartCamera - (mousePos - _dragStartMouse)	
	
	_boundaryClamps()

func _boundaryClamps() -> void:
	var halfVP := get_viewport_rect().size * 0.5
	global_position.x = clampf(global_position.x, limit_left + halfVP.x, limit_right - halfVP.x)
	global_position.y = clampf(global_position.y, limit_top + halfVP.y, limit_bottom - halfVP.y)
	
	
