class_name GameClock
extends Resource

@export var totalGameMinutes: int = 0

func getMinute() -> int:
	return totalGameMinutes % 60

func getHour() -> int:
	return (totalGameMinutes / 60) % 24

func getDay() -> int:
	return (totalGameMinutes / 1440) % 7

func getWeek() -> int:
	return (totalGameMinutes / 10080)
