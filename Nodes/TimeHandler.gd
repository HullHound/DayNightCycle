## This script defines a Node that calculates a clock time from the total elapsed time, split into specified intervals.
## And emit's a signal when the displayed time changes.

extends Node

class_name TimeHandler

# Internal variables
var current_time : int = -1

# Exposed variables
## Length of day in seconds
@export var day_length_seconds : float = 600
## The displayed game time interval to count as time having changed (eg. 1 minute, 10 minute, 15 minute, 20 minute, 30 minute)
@export_range(1, 60) var display_interval_minutes : int = 15

# Signals
signal time_changed(current_time: String)

## Function to handle time-related functionality
func set_time(total_time_seconds: float) -> void:
	# Calculate the current time in intervals
	var interval_length_in_seconds = day_length_seconds / float((60 / display_interval_minutes) * 24)
	var new_time = int(fmod(total_time_seconds, day_length_seconds) / interval_length_in_seconds)
	
	# If the time has changed, emit the signal
	if new_time != current_time:
		current_time = new_time
		time_changed.emit(get_display_time_of_day())

## Function to get the current time of day in HH:MM format
func get_display_time_of_day() -> String:
	var hours : int = current_time * display_interval_minutes / 60
	var minutes : int = (current_time * display_interval_minutes) % 60
	return String("%02d:%02d" % [hours, minutes])
