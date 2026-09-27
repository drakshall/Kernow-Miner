extends TextureRect

@export var phases: Array[DayPhase] = []

var _currentPhase := -1

func _ready() -> void:
	Orchestrator.gameHourTicked.connect(_hourTicked)
	_refreshPhase()

func _hourTicked(_hour: int) -> void:
	_refreshPhase()

func _refreshPhase() -> void:
	var hour := Orchestrator.getHour()
	var phase := _phaseHour(hour)
	if phase == _currentPhase:
		return
	_currentPhase = phase
	if phase >= 0 and phase < phases.size():
		texture = phases[phase].texture

func _phaseHour(hour: int) -> int:
	var phase := phases.size() - 1
	for i in phases.size():
		if hour >= phases[i].startHour:
			phase = i
	return phase
