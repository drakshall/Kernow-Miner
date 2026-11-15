class_name MineStructure
extends Resource

enum State {
	pLANNED,
	uNDERcONSTRUCTION,
	oPEN,
	cLOSED,
	dERELICT,
}

var id: int
var costBookAssociationId: int = -1
var displayName: String
var buildingCondition: int
var buildingState: State
var buildingConstructionProgress: int
var assignedWorkerIds: Array[int]
