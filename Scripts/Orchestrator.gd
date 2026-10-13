extends Node

#------------------------- Connections & startup -------------------------# 

signal gameMinuteTicked(totalGameMinutes: int)
signal gameHourTicked(hour: int)
signal gameDayTicked(day: int)
signal gameWeekTicked(week: int)
signal clockPauseChanged(paused: bool)
signal gameSpeedChanged(speed: int)
signal speedLockChanged(locked: bool)

const uNITSpERmINUTE := 10
const tICKiNTERVAL := 1.0 / uNITSpERmINUTE

var _accumulator: int = 0
var _pauseSources: Dictionary = {}
var _speedLockSources: Dictionary = {}
var clockState: GameClock
@onready var _clock: Timer = $ClockTimer

func _ready() -> void:
	clockState = GameClock.new()
	_clock.timeout.connect(_onHeartbeat)

#------------ Tick logic ------------#

func _onHeartbeat() -> void:
	_accumulator += clockState.gameSpeed
	while _accumulator >= uNITSpERmINUTE:
		_accumulator -= uNITSpERmINUTE
		_emitTimeTicks()

func _emitTimeTicks() -> void:
	var previousHour := clockState.getHour()
	var previousDay := clockState.getDay()
	var previousWeek := clockState.getWeek()
	
	clockState.advanceMinute()
	gameMinuteTicked.emit(clockState.totalGameMinutes)
	
	if clockState.getHour() != previousHour:
		gameHourTicked.emit(clockState.getHour())
	if clockState.getDay() != previousDay:
		gameDayTicked.emit(clockState.getDay())
	if clockState.getWeek() != previousWeek:
		gameWeekTicked.emit(clockState.getWeek())

func _shouldPauseCheck() -> bool:
	return clockState.gameSpeed == 0 or not _pauseSources.is_empty()

func _applyClockState() -> void:
	var shouldPause := _shouldPauseCheck()
	clockState.isPaused = shouldPause
	if _clock.paused != shouldPause:
		_clock.paused = shouldPause
		clockPauseChanged.emit(shouldPause)

#--------------------------- Time API -------------------------------#

#------ Speed controls ------#

func pauseClock(source: StringName) -> void:
	if _pauseSources.has(source):
		return
	_pauseSources[source] = true
	_applyClockState()

func resumeClock(source: StringName) -> void:
	if not _pauseSources.has(source):
		return
	_pauseSources.erase(source)
	_applyClockState()

func isClockPaused() -> bool:
	return clockState.isPaused

func setGameSpeed(speed: int) -> void:
	clockState.setSpeed(speed)
	_applyClockState()
	gameSpeedChanged.emit(clockState.gameSpeed)

func getGameSpeed() -> int:
	return clockState.gameSpeed

#------ Time access controls ------#

func lockSpeed(source: StringName) -> void:
	if _speedLockSources.has(source):
		return
	_speedLockSources[source] = true
	if _speedLockSources.size() == 1:
		speedLockChanged.emit(true)

func unlockSpeed(source: StringName) -> void:
	if not _speedLockSources.has(source):
		return
	_speedLockSources.erase(source)
	if _speedLockSources.is_empty():
		speedLockChanged.emit(false)

func isSpeedLocked() -> bool:
	return not _speedLockSources.is_empty()
