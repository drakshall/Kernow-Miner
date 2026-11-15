class_name IndustrialStructureRegistry
extends Resource

var _industrialStructures: Dictionary[int, IndustrialStructure]
var _nextId: int = 1

func register(e: IndustrialStructure) -> int:
	assert(e.id == -1, "Mine structure already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_industrialStructures[e.id] = e
	return e.id

func grab(id: int) -> IndustrialStructure:
	return _industrialStructures.get(id)

func all() -> Array[IndustrialStructure]:
	return _industrialStructures.values()
