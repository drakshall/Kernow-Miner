class_name IndustrialStructure
extends Resource

enum State {
	pLANNED,
	uNDERcONSTRUCTION,
	oPEN,
	cLOSED,
	dERELICT,
}

enum Type {
	wHIMhOUSE,
	pUMPINGhOUSE,
	sTAMPhOUSE,
	mULEsHED,
	dRESSINGtABLE,
	mINERSdRY,
	cOUNTINGhOUSE,
	
}

var id: int
var costBookAssociationId: int = -1
var displayName: String
var buildingCondition: int
var buildingState: State
var buildingConstructionProgress: int
var assignedPeonIds: Array[int]
var type: Type
