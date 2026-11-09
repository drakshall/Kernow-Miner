class_name BaseStructure
extends Resource

enum State {
	pLANNED,
	uNDERcONSTRUCTION,
	oPEN,
	cLOSED,
	dERELICT,
}

enum Location {
	mINE,
	vILLAGE,
	wIDERwORLD,
}

var id: int
var enterpriseId: int = -1
var displayName: String
var buildingCondition: int
var buildingState: State
var buildingConstructionProgress: int
var buildingLocation: Location
var workerIds: Array[int]
