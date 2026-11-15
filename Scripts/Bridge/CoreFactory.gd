class_name CoreFactory
extends Resource
# factory class that establishes the starting conditions of the simulation

# ------------------------ Initialisation ---------------------- #

var peonRegistry: PeonRegistry
var householdRegistry: HouseholdRegistry
var _rng: RandomNumberGenerator

const lASTnAMES := [
	"Pengelly", "Dyer", "Angwin", "Jekyll", "Jenkins", "Kelly", "Beaglehole", "Tregona", "Nance", "Chynoweth", "Penrose", "Penhaligon", "Pascoe", "Woon", "Kernick", "Grose", "Boson", "Boscawen", "Hocking", "Snell", "Rodda", "Kempthorne", "Chenoweth", "Pendarves", "Penberthy", "Penna", "Trembath", "Trethowan", "Tregenna", "Trefethen", "Treblilcock", "Roscoe", "Walker", "Watson", "Evans", "Trevorrow", "Trewhella", "Vingoe",
]

const mALEnAMES := [
	"Jago", "Jowan", "Jack", "Richard", "Jowen", "Paul", "Josep", "Kitto", "Davydh", "Lowen", "Ruan", "Caswyn", "Petroc", "Perran", "Arthur", "Tristan", "Locryn", "Cadan", "Jory", "Denzel", "Mawgan", "Germoe", "Gerran", "Levan", "Treve", "Caradoc", "Androw", "Aswen", "Klemmo"
]

const fEMALEnAMES := [
	"Demelza", "Elowen", "Isolde", "Jenifer", "Kensa", "Lowenna", "Kerenza", "Morwenna", "Tamsyn", "Tegen", "Ysella", "Senara", "Breaca", "Endellion", "Merryn", "Wenna", "Kaja", "Elys", "Morgana", "Kenwyn", "Kelyn"
]

func _randomInit() -> void:
	_rng = RandomNumberGenerator.new()
	_rng.randomize()

func setSeed(seed: int) -> void:
	_rng.seed = seed

func setRegistries(pr: PeonRegistry, hr: HouseholdRegistry) -> void:
	peonRegistry = pr
	householdRegistry = hr

# ------------------------------ Creation Methods ------------------------------- #

func _spawnPeon(params: Dictionary = {}) -> Peon:
	var p := Peon.new()

func _spawnHousehold

func spawnFamily

func spawnLoner

# ------------------------------- Randomiser Helpers------------------------------ #

func _randomFirstName(isMale: bool) -> String

func _randomLastName() -> String

func _randomParentAge() -> int

func _randomChildCount(maxChildAge: int) -> int

func _randomEducation(age: int) -> int

func _randomOccupation(age: int, genderRole: bool) -> Peon.Occupation
