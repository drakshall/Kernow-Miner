class_name ShareRegistry
extends Resource

var _shares: Dictionary[int, ShareCertificate]
var _nextId: int = 1

func create(enterpriseId: int, holderId: int, units: int, type: ShareCertificate.ShareType) -> ShareCertificate:
	var s := ShareCertificate.new()
	s.id = _nextId
	_nextId += 1
	s.enterpriseId = enterpriseId
	s.holderId = holderId
	s.units = units
	s.type = type
	_shares[s.id] = s
	return s
