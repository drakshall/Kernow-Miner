class_name HungerSystem
extends Resource

var familyRegistry: FamilyRegistry
var peonRegistry: PeonRegistry

func compileFamilyHungerRate(family: Family) -> int:
	var familyHungerRate := 0
	for memberId in family.memberIds:
		var peon := peonRegistry.grab(memberId)
		if peon.alive:
			familyHungerRate += peon.getHungerRate()
	family.hungerRate = familyHungerRate
	return familyHungerRate

func initFamilyHungerRates() -> void:
	for family in familyRegistry.all():
		compileFamilyHungerRate(family)

func hungerPoll() -> void:
	for family in familyRegistry.all():
		family.foodStores -= family.hungerRate
