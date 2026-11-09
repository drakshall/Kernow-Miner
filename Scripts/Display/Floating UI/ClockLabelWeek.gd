extends Label

func _ready() -> void:
	_Refresh(0)
	Orchestrator.gameWeekTicked.connect(_Refresh)

func _Refresh(_value: int) -> void:
	text = "Week %s" %(Orchestrator.clockState.getWeekOfYear())
