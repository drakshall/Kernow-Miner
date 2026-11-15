class_name ShareRegistry
extends Resource

var _shares: Dictionary[int, Share] = {}
var _nextId: int = 1

func register(e: Share) -> int:
	assert(e.id == -1, "Share already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_shares[e.id] = e
	return e.id

func grab(id: int) -> Share:
	return _shares.get(id)

func all() -> Array[Share]:
	return _shares.values()
