extends Node

#------------------------- Connections & startup -------------------------# 

signal gameHourTicked(hour: int)
signal gameDayTicked(dayOfYear: int)
signal gameWeekTicked(weekOfYear: int)
signal gameSeasonTicked(season: int)
signal gameYearTicked(year: int)
signal clockPauseChanged(paused: bool)
signal gameSpeedChanged(multiplier: int)
signal speedLockChanged(locked: bool)

const sPEEDsCALE := 1024
const hEARTBEATSpERhOUR := 10 
const tICKiNTERVAL := 1.0 / hEARTBEATSpERhOUR
const uNITSpERhOUR := hEARTBEATSpERhOUR * sPEEDsCALE

var _accumulator: int = 0
var _pauseSources: Dictionary = {}
var _speedLockSources: Dictionary = {}
var clockState: GameClock
@onready var _clock: Timer = $ClockTimer

func _ready() -> void:
	clockState = GameClock.new()
	clockState.setSpeed(sPEEDsCALE)
	_clock.wait_time = tICKiNTERVAL
	_clock.timeout.connect(_onHeartbeat)
	_applyClockState()

#------------ Tick logic ------------#

func _onHeartbeat() -> void:
	_accumulator += clockState.gameSpeed
	while _accumulator >= uNITSpERhOUR:
		_accumulator -= uNITSpERhOUR
		_emitTimeTicks()

func _emitTimeTicks() -> void:
	var previousDay := clockState.getDayOfYear()
	var previousWeek := clockState.getDayOfWeek()
	var previousYear := clockState.getYear()
	
	clockState.advanceHour()
	gameHourTicked.emit(clockState.getHour())
	
	if clockState.getDayOfYear() != previousDay:
		gameDayTicked.emit(clockState.getDayOfYear())
	if clockState.getWeekOfYear() != previousWeek:
		gameWeekTicked.emit(clockState.getWeekOfYear())
	if clockState.getYear() != previousYear:
		gameYearTicked.emit(clockState.getYear())

func _shouldPauseCheck() -> bool:
	return clockState.gameSpeed == 0 or not _pauseSources.is_empty()

func _applyClockState() -> void:
	var shouldPause := _shouldPauseCheck()
	clockState.isPaused = shouldPause
	if _clock.paused != shouldPause:
		_clock.paused = shouldPause
		clockPauseChanged.emit(shouldPause)

#--------------------------- Time API -------------------------------#

#---------- Queries ----------#

func getTotalGameHours() -> int:
	return clockState.totalGameHours

func getGameSpeed() -> int:
	return clockState.gameSpeed

func isClockPaused() -> bool:
	return clockState.isPaused

func isSpeedLocked() -> bool:
	return not _speedLockSources.is_empty()

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

func setGameSpeed(speed: int) -> void:
	clockState.setSpeed(speed)
	_applyClockState()
	gameSpeedChanged.emit(clockState.gameSpeed)

#------ Time access controls ------#
# note: This code is currently dormant and planned for use with something like an event system that forces an unchangeable pause state by locking the controls. 

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
