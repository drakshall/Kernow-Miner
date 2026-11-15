class_name PeonRegistry
extends Resource

var _peons: Dictionary[int, Peon] = {}
var _nextId: int = 1

func register(e: Peon) -> int:
	assert(e.id == -1, "Peon already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_peons[e.id] = e
	return e.id

func grab(id: int) -> Peon:
	return _peons.get(id)

func all() -> Array[Peon]:
	return _peons.values()
