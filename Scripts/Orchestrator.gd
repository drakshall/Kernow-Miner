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

# Time internal functions

func _setupClock() -> void:
	_clock = Timer.new()
	_clock.wait_time = 1.0
	_clock.autostart = true
	_clock.timeout.connect(_onClockTimeout)
	add_child(_clock)

func _onClockTimeout() -> void:
	var previousHour := clockState.getHour()
	clockState.totalGameMinutes += 1
	gameMinuteTicked.emit(clockState.totalGameMinutes)
	if clockState.getHour() != previousHour:
		gameHourTicked.emit(clockState.getHour())

func _applyClockState(restartTimer: bool = false) -> void:
	var shouldPause := isClockPaused()
	if not shouldPause:
		var newWaitTime := 1.0 / _gameSpeed
		if restartTimer:
			_clock.start(newWaitTime)
		else:
			_clock.wait_time = newWaitTime
	if _clock.paused != shouldPause:
		_clock.paused = shouldPause
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
	_applyClockState()

func resumeClock(source: StringName) -> void:
	if not _pauseSources.has(source):
		return
	_pauseSources.erase(source)
	_applyClockState()

func isClockPaused() -> bool:
	return _gameSpeed == 0.0 or not _pauseSources.is_empty()

func setGameSpeed(speed: float) -> void:
	_gameSpeed = max(speed, 0.0)
	_applyClockState(true)
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
