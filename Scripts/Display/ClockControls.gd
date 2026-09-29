extends HBoxContainer

@export var buttons: Dictionary[StringName, TextureButton] = {}
@export var controlMap: Dictionary[StringName, float] = {
	&"PauseButton": 0.0,
	&"1xButton": 1.0,
	&"2xButton": 2.0,
	&"5xButton": 5.0,
	&"10xButton": 10.0,
}

func _ready() -> void:
	for id in buttons:
		var button := buttons[id]
		button.toggle_mode = true
		button.pressed.connect(_onButtonPressed.bind(id))
	
	Orchestrator.clockPauseChanged.connect(_onPauseChanged)
	Orchestrator.gameSpeedChanged.connect(_onSpeedChanged)
	Orchestrator.speedLockChanged.connect(_applySpeedLock)
	
	_syncButtons()
	_applySpeedLock(Orchestrator.isSpeedLocked())

func _onButtonPressed(id: StringName) -> void:
	Orchestrator.setGameSpeed(controlMap[id])

func _onPauseChanged(_paused: bool) -> void:
	_syncButtons()

func _onSpeedChanged(_speed: float) -> void:
		_syncButtons()

func _syncButtons() -> void:
	var speed := Orchestrator.getGameSpeed()
	var paused := Orchestrator.isClockPaused()
	for id in controlMap:
		var shouldSelect := false
		if paused:
			shouldSelect = controlMap[id] == 0.0
		else:
			shouldSelect = is_equal_approx(controlMap[id],speed)
		buttons[id].button_pressed = shouldSelect

func _applySpeedLock(locked: bool) -> void:
	for id in controlMap:
		if controlMap[id] == 0.0:
			continue
		buttons[id].disabled = locked
