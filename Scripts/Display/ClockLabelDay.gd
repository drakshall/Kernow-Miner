extends Label

const dAYnAMES := ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

func _ready() -> void:
	_Refresh(Orchestrator.clockState.totalGameMinutes)
	Orchestrator.gameMinuteTicked.connect(_Refresh)

func _Refresh(_totalGameMinutes: int) -> void:
	text = dAYnAMES[Orchestrator.getDay()]
