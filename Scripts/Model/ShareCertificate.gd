class_name ShareCertificate
extends Resource

enum ShareType {
	cOSTbOOK,
	lIMITED,
}

var id: int = -1
var enterpriseId: int = -1
var holderId: int = -1
var units: int
var type: ShareType
var acquisitionDate: int
