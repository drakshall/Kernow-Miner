class_name HousingStructureRegistry
extends Resource

var _housingStructures: Dictionary[int, HousingStructure]
var _nextId: int = 1

func register(e: HousingStructure) -> int:
	assert(e.id == -1, "Housing structure already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_housingStructures[e.id] = e
	return e.id

func grab(id: int) -> HousingStructure:
	return _housingStructures.get(id)

func all() -> Array[HousingStructure]:
	return _housingStructures.values()
