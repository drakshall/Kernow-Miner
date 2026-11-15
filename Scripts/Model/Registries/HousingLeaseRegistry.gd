class_name HousingLeaseRegistry
extends Resource

var _housingLeases: Dictionary[int, HousingLease]
var _nextId: int = 1

func register(e: HousingLease) -> int:
	assert(e.id == -1, "Housing lease already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_housingLeases[e.id] = e
	return e.id

func grab(id: int) -> HousingLease:
	return _housingLeases.get(id)

func all() -> Array[HousingLease]:
	return _housingLeases.values()
