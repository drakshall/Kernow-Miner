class_name Peon
extends Resource

enum Occupation {
	uNEMPLOYED,
	fARMER,
	bLACKSMITH,
	eNGINEER,
	mASON,
	sTOPER,
	lABOURER,
	dEVELOPER,
	tEAMSTER,
}

# Identity
var id: int = -1
var firstName: String
var lastName: String

# Vitals
var alive: bool
var happiness: int
var injured: bool
var soundOfMind: bool

# Characteristics 
var age: int
var sex: bool
var genderRole: bool
var occupation: Occupation
var placeOfWorkId: int = -1
var placeOfBirthId: int = -1
var personalLiquidCapital: int
#var allowanceRate: int


## Skills
#var social: int
#var blasting: int
#var spalling: int
#var hauling: int
#var interfacing: int
#var farming: int
#var accounting: int
#var masonry: int
#var engineering: int
#var smithing: int

# Relationships
var spouseId: int = -1
var parentIds: Array[int] = []
var familyId: int = -1


func getHungerRate() -> int:
	if age < 3: return 20
	if age < 6: return 35
	if age < 12: return 50
	if age < 16: return 80
	if age < 51: return 100
	if age < 66: return 80
	else: return 65

func getAllowanceRate() -> int:
	if age < 6: return 5
	if age < 12: return 10
	if age < 21: return 20
	else: return 75
