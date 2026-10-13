class_name GameClock
extends Resource

#---------------------- State ---------------------#

var totalGameMinutes: int = 0
var gameSpeed: int = 1
var isPaused: bool = false

#--------------- Mutation Functions ---------------#

func advanceMinute() -> void:
	totalGameMinutes += 1

func setSpeed(speed: int) -> void:
	gameSpeed = max(speed, 0)

#--------------- Derivation Functions -------------#

func getMinute() -> int:
	return totalGameMinutes % 60

func getHour() -> int:
	@warning_ignore("integer_division")
	return (totalGameMinutes / 60) % 24

func getDay() -> int:
	@warning_ignore("integer_division")
	return (totalGameMinutes / 1440) % 7

func getWeek() -> int:
	@warning_ignore("integer_division")
	return (totalGameMinutes / 10080)
