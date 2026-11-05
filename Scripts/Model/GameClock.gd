class_name GameClock
extends Resource

#---------------- Calendar Constants ---------------#

const hOURSpERdAY := 24
const dAYSpERwEEK := 7
const dAYSpERyEAR := 364
const wEEKSpERyEAR := 52

#---------------------- State ---------------------#

var totalGameHours: int = 0
var gameSpeed: int = 0
var isPaused: bool = false

#--------------- Mutation Functions ---------------#

func advanceHour() -> void:
	totalGameHours += 1

func setSpeed(speed: int) -> void:
	gameSpeed = max(speed, 0)

#--------------- Derivation Functions -------------#

func getHour() -> int:
	return totalGameHours % hOURSpERdAY

func getDayOfWeek() -> int:
	@warning_ignore("integer_division")
	return (totalGameHours / hOURSpERdAY) % dAYSpERwEEK

func getDayOfYear() -> int:
	@warning_ignore("integer_division")
	return (totalGameHours / hOURSpERdAY) % dAYSpERyEAR

func getWeekOfYear() -> int:
	@warning_ignore("integer_division")
	return getDayOfYear() / 7 + 1

func getYear() -> int:
	@warning_ignore("integer_division")
	return totalGameHours / (hOURSpERdAY * dAYSpERyEAR)
