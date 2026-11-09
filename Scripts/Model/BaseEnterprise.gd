class_name BaseEnterprise
extends Resource

enum Sector {
	mINING,
	aGRICULTURE,
	tRANSPORT,
	mANUFACTURE,
	cOLONIAL,
}

var id: int = -1
var displayName: String
var sector: Sector
var buildingIds: Array[int]
var totalShares: int
