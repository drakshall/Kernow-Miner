class_name HouseholdRegistry
extends Resource

var _households: Dictionary[int, Household] = {}
var _nextId: int = 1

func register(e: Household) -> int:
	assert(e.id == -1, "Household already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_households[e.id] = e
	return e.id

func grab(id: int) -> Household:
	return _households.get(id)

func all() -> Array[Household]:
	return _households.values()
