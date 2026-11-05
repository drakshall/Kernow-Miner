extends Label

const dAYnAMES := ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

func _ready() -> void:
	_Refresh(0)
	Orchestrator.gameDayTicked.connect(_Refresh)

func _Refresh(_value: int) -> void:
	text = dAYnAMES[Orchestrator.clockState.getDayOfWeek()]
