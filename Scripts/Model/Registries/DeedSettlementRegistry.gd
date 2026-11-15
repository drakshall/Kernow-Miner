class_name DeedSettlementRegistry
extends Resource

var _deedSettlements: Dictionary[int, DeedSettlement] = {}
var _nextId: int = 1

func register(e: DeedSettlement) -> int:
	assert(e.id == -1, "DeedSettlement already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_deedSettlements[e.id] = e
	return e.id

func grab(id: int) -> DeedSettlement:
	return _deedSettlements.get(id)

func all() -> Array[DeedSettlement]:
	return _deedSettlements.values()
