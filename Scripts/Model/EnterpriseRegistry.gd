class_name EnterpriseRegistry
extends Resource

var _enterprises: Dictionary[int, BaseEnterprise]
var _nextId: int = 1

func register(e: BaseEnterprise) -> int:
	e.id = _nextId
	_nextId += 1
	_enterprises[e.id] = e
	return e.id
