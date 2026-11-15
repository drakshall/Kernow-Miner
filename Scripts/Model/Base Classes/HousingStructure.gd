class_name HousingStructure
extends Resource

enum State {
	pLANNED,
	uNDERcONSTRUCTION,
	oCCUPIED,
	vACANT,
	dERELICT,
}

var id: int
var HousingLeaseId: int
var displayName: String
var buildingCondition: int
var buildingState: State
var buildingConstructionProgress: int
