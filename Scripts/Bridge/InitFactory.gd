class_name InitFactory
extends Resource
# factory class that establishes the starting conditions of the simulation

# ------------------------ Initialisation ---------------------- #

var peonRegistry: PeonRegistry
var familyRegistry: FamilyRegistry
var _rng: RandomNumberGenerator

#const lASTnAMES := [
	#"Pengelly", "Dyer", "Angwin", "Jekyll", "Jenkins", "Kelly", "Beaglehole", "Tregona", "Nance", "Chynoweth", "Penrose", "Penhaligon", "Pascoe", "Woon", "Kernick", "Grose", "Boson", "Boscawen", "Hocking", "Snell", "Rodda", "Kempthorne", "Chenoweth", "Pendarves", "Penberthy", "Penna", "Trembath", "Trethowan", "Tregenna", "Trefethen", "Treblilcock", "Roscoe", "Walker", "Watson", "Evans", "Trevorrow", "Trewhella", "Vingoe"
#]
#
#const mALEnAMES := [
	#"Jago", "Jowan", "Jack", "Richard", "Jowen", "Paul", "Josep", "Kitto", "Davydh", "Lowen", "Ruan", "Caswyn", "Petroc", "Perran", "Arthur", "Tristan", "Locryn", "Cadan", "Jory", "Denzel", "Mawgan", "Germoe", "Gerran", "Levan", "Treve", "Caradoc", "Androw", "Aswen", "Klemmo"
#]
#
#const fEMALEnAMES := [
	#"Demelza", "Elowen", "Isolde", "Jenifer", "Kensa", "Lowenna", "Kerenza", "Morwenna", "Tamsyn", "Tegen", "Ysella", "Senara", "Breaca", "Endellion", "Merryn", "Wenna", "Kaja", "Elys", "Morgana", "Kenwyn", "Kelyn"
#]

enum lASTnAMES {
	Pengelly, Dyer, Angwin, Jekyll, Jenkins, Kelly, Beaglehole, Tregona, Nance, Chynoweth, Penrose, Penhaligon, Pascoe, Woon, Kernick, Grose, Boson, Boscawen, Hocking, Snell, Rodda, Kempthorne, Chenoweth, Pendarves, Penberthy, Penna, Trembath, Trethowan, Tregenna, Trefethen, Treblilcock, Roscoe, Walker, Watson, Evans, Trevorrow, Trewhella, Vingoe
}

enum mALEnAMES {
	Jago, Jowan, Jack, Richard, Jowen, Paul, Josep, Kitto, Davydh, Lowen, Ruan, Caswyn, Petroc, Perran, Arthur, Tristan, Locryn, Cadan, Jory, Denzel, Mawgan, Germoe, Gerran, Levan, Treve, Caradoc, Androw, Aswen, Klemmo
}

enum fEMALEnAMES {
	Demelza, Elowen, Isolde, Jenifer, Kensa, Lowenna, Kerenza, Morwenna, Tamsyn, Tegen, Ysella, Senara, Breaca, Endellion, Merryn, Wenna, Kaja, Elys, Morgana, Kenwyn, Kelyn
}

# ------------------------------- Randomiser Helpers------------------------------ #

func _randomInit(seedInput: String) -> void:
	_rng = RandomNumberGenerator.new()
	_rng.seed = seedInput.hash()

func _pick(dict: Dictionary) -> Variant:
	return dict[_rng.randi_range(0, dict.size() - 1)]

# ------------------------------ Creation Methods ------------------------------- #

func _spawnPeon(params: Dictionary = {}) -> Peon:
	
	var rolledSex: bool = _rng.randf() < 0.5
	var rolledAge: bool = _rng.randi_range(21, 70)
	var rolledHunger: bool = _rng.randi_range(21, 70)
	var rolledHappiness: bool = _rng.randi_range(1, 100)
	var rolledLiquidCapital: bool = _rng.randi_range(20, 200)
	var rolledOccupation: String = _pick(Peon.Occupation)
	var finalisedSex: bool = params.get("sex", rolledSex)
	var rolledLastName: String = _pick(lASTnAMES)
	var rolledFirstName: String
	if finalisedSex:
		rolledFirstName = _pick(mALEnAMES)
	else:
		rolledFirstName = _pick(fEMALEnAMES)
	
	var p := Peon.new()
	
	p.sex = params.get("sex", finalisedSex)
	p.genderRole = params.get("genderRole", finalisedSex)
	p.firstName = params.get("firstName", rolledFirstName)
	p.lastName = params.get("lastName", rolledLastName)
	p.age = params.get("age", rolledAge)
	p.hunger = params.get("hunger", rolledHunger)
	p.happiness = params.get("happiness", rolledHappiness)
	p.injured = params.get("injured", false)
	p.alive = params.get("alive", true)
	p.placeOfBirthId = params.get("placeOfBirthId", -1)
	p.placeOfWorkId = params.get("placeOfWorkId", -1)
	p.personalLiquidCapital = params.get("personalLiquidCapital", rolledLiquidCapital)
	p.spouseId = params.get("spouseId", -1)
	p.familyId = params.get("familyId", -1)
	p.parentIds = params.get("parentIds", [-1, -1])
	
	peonRegistry.register(p)
	return p

func _spawnFamily(params: Dictionary = {}) -> Family:
	var rolledLastName: String = _pick(lASTnAMES)
	
	var f := Family.new()
	
	var id: int = -1
	var leasedHousingId: int = -1
	var ownedHousingId: int = -1
	var memberIds: Array[int] = []
	var foodStores: int
	var familyLiquidCapital: int
	var economicHeadId: int = -1
	var legalHeadId: int = -1
	
	familyRegistry.register(f)
	return f
	
