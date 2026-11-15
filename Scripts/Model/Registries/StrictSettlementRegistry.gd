class_name StrictSettlementRegistry
extends Resource

var _StrictSettlements: Dictionary[int, StrictSettlement] = {}
var _nextId: int = 1

func register(e: StrictSettlement) -> int:
	assert(e.id == -1, "StrictSettlement already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_StrictSettlements[e.id] = e
	return e.id

func grab(id: int) -> StrictSettlement:
	return _StrictSettlements.get(id)

func all() -> Array[StrictSettlement]:
	return _StrictSettlements.values()
