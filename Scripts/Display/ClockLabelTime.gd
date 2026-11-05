extends Label

func _ready() -> void:
	_Refresh(0)
	Orchestrator.gameHourTicked.connect(_Refresh)
#
func _Refresh(_totalGameMinutes: int) -> void:
	text = "%02d" %(Orchestrator.clockState.getHour())
