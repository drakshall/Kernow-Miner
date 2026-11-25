extends Node
class_name Testing

var familyRegistry: FamilyRegistry
var hungerSystem: HungerSystem

var cumulativeFoodStoresStart: int
var cumulativeFoodStoresEnd: int
var cumulativeHungerRate: int

func validateHungerOperation() -> void:
	Orchestrator.generateArbitraryFamilies(1000)
	cumulativeFoodStoresStart = 0
	cumulativeHungerRate = 0
	cumulativeFoodStoresEnd = 0
	for family in familyRegistry.all():
		cumulativeFoodStoresStart += family.foodStores
		cumulativeHungerRate += hungerSystem.compileFamilyHungerRate(family)
	hungerSystem.hungerPoll()
	for family in familyRegistry.all():
		cumulativeFoodStoresEnd += family.foodStores
	if cumulativeFoodStoresEnd == cumulativeFoodStoresStart:
		return print("Food stores identical, test failed")
	elif cumulativeFoodStoresEnd != cumulativeFoodStoresStart - cumulativeHungerRate:
		return print("Food stores do not match expected state, test failed")
	elif cumulativeFoodStoresEnd == cumulativeFoodStoresStart - cumulativeHungerRate:
		return print("Food stores match expected state, test succeeded")
	
