class_name CostBookAssociationRegistry
extends Resource

var _costBookAssociations: Dictionary[int, CostBookAssociation] = {}
var _nextId: int = 1

func register(e: CostBookAssociation) -> int:
	assert(e.id == -1, "CostBookAssociation already registered: id=%d" % e.id)
	e.id = _nextId
	_nextId += 1
	_costBookAssociations[e.id] = e
	return e.id

func grab(id: int) -> CostBookAssociation:
	return _costBookAssociations.get(id)

func all() -> Array[CostBookAssociation]:
	return _costBookAssociations.values()
