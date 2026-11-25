class_name ClassFactory
extends Resource
# factory class for atomic class construction

# ------------------------ Initialisation ---------------------- #

var peonRegistry: PeonRegistry
var familyRegistry: FamilyRegistry
var masterRng: RandomNumberGenerator

const lASTnAMES := [
	"Pengelly", "Dyer", "Angwin", "Jekyll", "Jenkins", "Kelly", "Beaglehole", "Tregona", "Nance", "Chynoweth", "Penrose", "Penhaligon", "Pascoe", "Woon", "Kernick", "Grose", "Boson", "Boscawen", "Hocking", "Snell", "Rodda", "Kempthorne", "Chenoweth", "Pendarves", "Penberthy", "Penna", "Trembath", "Trethowan", "Tregenna", "Trefethen", "Treblilcock", "Roscoe", "Walker", "Watson", "Evans", "Trevorrow", "Trewhella", "Vingoe"
]

const mALEnAMES := [
	"Jago", "Jowan", "Jack", "Richard", "Jowen", "Paul", "Josep", "Kitto", "Davydh", "Lowen", "Ruan", "Caswyn", "Petroc", "Perran", "Arthur", "Tristan", "Locryn", "Cadan", "Jory", "Denzel", "Mawgan", "Germoe", "Gerran", "Levan", "Treve", "Caradoc", "Androw", "Aswen", "Klemmo"
]

const fEMALEnAMES := [
	"Demelza", "Elowen", "Isolde", "Jenifer", "Kensa", "Lowenna", "Kerenza", "Morwenna", "Tamsyn", "Tegen", "Ysella", "Senara", "Breaca", "Endellion", "Merryn", "Wenna", "Kaja", "Elys", "Morgana", "Kenwyn", "Kelyn"
]

#enum lASTnAMES {
	#Pengelly, Dyer, Angwin, Jekyll, Jenkins, Kelly, Beaglehole, Tregona, Nance, Chynoweth, Penrose, Penhaligon, Pascoe, Woon, Kernick, Grose, Boson, Boscawen, Hocking, Snell, Rodda, Kempthorne, Chenoweth, Pendarves, Penberthy, Penna, Trembath, Trethowan, Tregenna, Trefethen, Treblilcock, Roscoe, Walker, Watson, Evans, Trevorrow, Trewhella, Vingoe
#}
#
#enum mALEnAMES {
	#Jago, Jowan, Jack, Richard, Jowen, Paul, Josep, Kitto, Davydh, Lowen, Ruan, Caswyn, Petroc, Perran, Arthur, Tristan, Locryn, Cadan, Jory, Denzel, Mawgan, Germoe, Gerran, Levan, Treve, Caradoc, Androw, Aswen, Klemmo
#}
#
#enum fEMALEnAMES {
	#Demelza, Elowen, Isolde, Jenifer, Kensa, Lowenna, Kerenza, Morwenna, Tamsyn, Tegen, Ysella, Senara, Breaca, Endellion, Merryn, Wenna, Kaja, Elys, Morgana, Kenwyn, Kelyn
#}

# ------------------------------- Randomiser Helpers------------------------------ #

func _pickArrayWith(rng: RandomNumberGenerator, arr: Array) -> Variant:
	return arr[rng.randi_range(0, arr.size() - 1)]
	
func _pickEnumWith(rng: RandomNumberGenerator, enumDict: Dictionary) -> int:
	var vals := enumDict.values()
	return vals[rng.randi_range(0, vals.size() - 1)]

# ------------------------------ Creation Methods ------------------------------- #

func _spawnPeon(params: Dictionary = {}) -> Peon:
	var p := Peon.new()
	peonRegistry.register(p)
	var derivedSeed: int
	derivedSeed = hash(str(params.get("familySeed")) + str(params.get("slot")))
	var localRng := RandomNumberGenerator.new()
	localRng.seed = derivedSeed
	
	var rolledSex: bool = localRng.randf() < 0.5
	var rolledAge: int = localRng.randi_range(21, 70)
	var rolledHappiness: int = localRng.randi_range(1, 100)
	var rolledLiquidCapital: int = localRng.randi_range(20, 200)
	var rolledOccupation: int = _pickEnumWith(localRng, Peon.Occupation)
	var finalisedSex: bool = params.get("sex", rolledSex)
	var rolledLastName: String = _pickArrayWith(localRng, lASTnAMES)
	var rolledFirstName: String
	var parentIds: Array = params.get("parentIds", [-1, -1])
	if finalisedSex:
		rolledFirstName = _pickArrayWith(localRng, mALEnAMES)
	else:
		rolledFirstName = _pickArrayWith(localRng, fEMALEnAMES)
	
	p.sex = params.get("sex", finalisedSex)
	p.genderRole = params.get("genderRole", finalisedSex)
	p.firstName = params.get("firstName", rolledFirstName)
	p.lastName = params.get("lastName", rolledLastName)
	p.age = params.get("age", rolledAge)
	p.happiness = params.get("happiness", rolledHappiness)
	p.injured = params.get("injured", false)
	p.alive = params.get("alive", true)
	p.soundOfMind = params.get("soundOfMind", true)
	p.placeOfBirthId = params.get("placeOfBirthId", -1)
	p.placeOfWorkId = params.get("placeOfWorkId", -1)
	p.occupation = params.get("occupation", rolledOccupation)
	p.personalLiquidCapital = params.get("personalLiquidCapital", rolledLiquidCapital)
	p.spouseId = params.get("spouseId", -1)
	p.familyId = params.get("familyId", -1)
	p.parentIds.assign(parentIds)
	
	return p

func spawnFamily(params: Dictionary = {}) -> Family:
	var f := Family.new()
	familyRegistry.register(f)
	var familySeed := _rng.randi()
	var localRng := RandomNumberGenerator.new()
	localRng.seed = familySeed
	
	var rolledLastName: String = _pickArrayWith(localRng, lASTnAMES)
	var rolledLiquidCapital: int = localRng.randi_range(100, 800)
	var rolledFoodStores: int = localRng.randi_range(100, 500)
	var rolledChildCount: int = localRng.randi_range(0, 6)
	var rolledHusbandAge: int = localRng.randi_range(21, 50)
	var rolledWifeAge: int = localRng.randi_range(21, 50)
	
	var memberParams: Dictionary = {
		lastName = params.get("familyLastName", rolledLastName),
		familyId = params.get("familyId", f.id),
		familySeed = params.get("familySeed", familySeed)
	}
	
	var husbandParams := memberParams.duplicate()
	husbandParams["sex"] = true
	husbandParams["age"] = params.get("husbandAge", rolledHusbandAge)
	husbandParams["slot"] = "husband"
	var wifeParams := memberParams.duplicate()
	wifeParams["sex"] = false
	wifeParams["age"] = params.get("wifeAge", rolledWifeAge)
	wifeParams["slot"] = "wife"
	var husband := _spawnPeon(husbandParams)
	var wife := _spawnPeon(wifeParams)
	husband.spouseId = wife.id
	wife.spouseId = husband.id
	f.memberIds.append(husband.id)
	f.memberIds.append(wife.id)
	
	var youngestParent := mini(husband.age, wife.age)
	var maxChildAge := mini(youngestParent - 16, 21)
	var finalisedChildCount: int = params.get("childCount", rolledChildCount)
	for i in finalisedChildCount:
		var childAge := localRng.randi_range(0, maxChildAge)
		var rolledSex: bool = localRng.randf() < 0.5
		var childParams := memberParams.duplicate()
		childParams["sex"] = rolledSex
		childParams["age"] = childAge
		childParams["parentIds"] = [husband.id, wife.id]
		childParams["slot"] = "child" + str(i)
		var child := _spawnPeon(childParams)
		f.memberIds.append(child.id)
	
	f.spawnSeed = familySeed
	f.leasedHousingId = params.get("leasedHousingId", -1)
	f.ownedHousingId = params.get("ownedHousingId", -1)
	f.foodStores = params.get("foodStores", rolledFoodStores)
	f.familyLiquidCapital = params.get("familyLiquidCapital", rolledLiquidCapital)
	f.legalHeadId = husband.id
	f.economicHeadId = husband.id
	
	return f
	
