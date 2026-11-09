extends HBoxContainer

@export var buttons: Dictionary[StringName, TextureButton] = {}
@export var controlMap: Dictionary[StringName, int] = {
	&"1/8xButton": 128,
	&"1/4xButton": 256,
	&"1/2xButton": 512,
	&"PauseButton": 0,
	&"1xButton": 1024,
	&"2xButton": 2048,
	&"5xButton": 5120,
	&"10xButton": 10240,
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

func _onSpeedChanged(_speed: int) -> void:
	_syncButtons()

func _syncButtons() -> void:
	var speed := Orchestrator.getGameSpeed()
	var paused := Orchestrator.isClockPaused()
	for id in controlMap:
		var shouldSelect := false
		if paused:
			shouldSelect = controlMap[id] == 0
		else:
			shouldSelect = controlMap[id] == speed
		buttons[id].button_pressed = shouldSelect

func _applySpeedLock(locked: bool) -> void:
	for id in controlMap:
		if controlMap[id] == 0:
			continue
		buttons[id].disabled = locked
