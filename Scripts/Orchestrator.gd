extends Node

#------------------------- Connections & startup -------------------------# 

signal gameMinuteTicked(totalGameMinutes: int)
signal gameHourTicked(hour: int)
signal clockPauseChanged(paused: bool)
signal gameSpeedChanged(speed: float)
signal speedLockChanged(locked: bool)

var clockState: GameClock
var _clock: Timer
var _gameSpeed: float = 1.0
var _pauseSources: Dictionary = {}
var _speedLockSources: Dictionary = {}

func _ready() -> void:
	clockState = GameClock.new()
	_setupClock()

# Time functions

func _setupClock() -> void:
	_clock = Timer.new()
	_clock.wait_time = 1.0
	_clock.autostart = true
	_clock.timeout.connect(_onClockTimeout)
	add_child(_clock)

func _onClockTimeout() -> void:
	var _previousHour := clockState.getHour()
	clockState.totalGameMinutes += 1
	gameMinuteTicked.emit(clockState.totalGameMinutes)
	if clockState.getHour() != _previousHour:
		gameHourTicked.emit(clockState.getHour())

func _applyPauseState() -> void:
	var shouldPause := isClockPaused()
	if _clock.paused == shouldPause:
		return
	_clock.paused = shouldPause
	if not shouldPause:
		_clock.wait_time = 1 / _gameSpeed
	clockPauseChanged.emit(shouldPause)

#--------------------------- Time API -------------------------------#

func getMinute() -> int:
	return clockState.getMinute()

func getHour() -> int:
	return clockState.getHour()

func getDay() -> int:
	return clockState.getDay()

func getWeek() -> int:
	return clockState.getWeek()

func pauseClock(source: StringName) -> void:
	if _pauseSources.has(source):
		return
	_pauseSources[source] = true
	_applyPauseState()

func resumeClock(source: StringName) -> void:
	if not _pauseSources.has(source):
		return
	_pauseSources.erase(source)
	_applyPauseState()

func togglePause(source: StringName) -> void:
	if _pauseSources.has(source):
		resumeClock(source)
	else:
		pauseClock(source)

func isClockPaused() -> bool:
	return not _pauseSources.is_empty()

func setGameSpeed(speed: float) -> void:
	if isSpeedLocked():
		return
	_gameSpeed = max(speed, 0.01)
	if not isClockPaused():
		_clock.wait_time = 1 / _gameSpeed
	gameSpeedChanged.emit(_gameSpeed)

func getGameSpeed() -> float:
	return _gameSpeed

func lockSpeed(source:StringName) -> void:
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
