class_name FamilyRegistry
extends Resource

var _families: Dictionary[int, Family] = {}
var _nextId: int = 1

func register(e: Family) -> int:
	assert(e.id == -1, "Household already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_families[e.id] = e
	return e.id

func grab(id: int) -> Family:
	return _families.get(id)

func all() -> Array[Family]:
	return _families.values()
