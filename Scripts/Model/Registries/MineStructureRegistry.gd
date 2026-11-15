class_name MineStructureRegistry
extends Resource

var _mineStructures: Dictionary[int, MineStructure]
var _nextId: int = 1

func register(e: MineStructure) -> int:
	assert(e.id == -1, "Mine structure already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_mineStructures[e.id] = e
	return e.id

func grab(id: int) -> MineStructure:
	return _mineStructures.get(id)

func all() -> Array[MineStructure]:
	return _mineStructures.values()
