extends Label

func _ready() -> void:
	_Refresh(Orchestrator.clockState.totalGameMinutes)
	Orchestrator.gameMinuteTicked.connect(_Refresh)

func _Refresh(_totalGameMinutes: int) -> void:
	text = "Week %s" %(Orchestrator.getWeek())
