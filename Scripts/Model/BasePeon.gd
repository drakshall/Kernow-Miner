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
var hunger: int
var happiness: int
var injured: bool

# Characteristics 
var age: int
var genderRole: bool
var occupation: Occupation
var placeOfWorkId: int = -1
var placeOfBirthId: int = -1
var education: int
var personalWealth: int
var allowanceRate: int

# Skills
var social: int
var blasting: int
var spalling: int
var hauling: int
var interfacing: int
var farming: int
var accounting: int
var masonry: int
var engineering: int
var smithing: int

# Relationships
var spouseId: int
var parentIds: Array[int]
var householdId: int
