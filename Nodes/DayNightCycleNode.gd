## This script defines a Node that facilitates a day night cycle and supplies a user friendly time of day.

extends Node

class_name DayNightCycleNode

## Should time advance (ie not paused)
@export var active : bool = true  # Flag to control whether time is advanced

# Internal variables
var current_day_percentage : float = 0.0
var total_time : float = 0.0
var day_length_seconds : float: 
	get:
		return $TimeHandler.day_length_seconds

# Reference to the children nodes
@onready var object_rotator : SampledObjectRotatorNode = $SampledObjectRotatorNode
@onready var light_transition : LightColorTransitionNode = $LightColorTransitionNode
@onready var time_handler : TimeHandler = $TimeHandler
@onready var light_intensity_transition_node: Node = $LightIntensityTransitionNode

signal time_changed(current_time: String)

func _ready() -> void:
	time_handler.time_changed.connect(process_time_changed)

# Called every frame
func _process(delta: float) -> void:
	if active:
		# Update total time
		total_time += delta

		# Update the day percentage based on the current time
		current_day_percentage = fmod(total_time, day_length_seconds) / day_length_seconds

		# Update nodes every frame
		update_nodes()

## Function to update child nodes based on the current time
func update_nodes() -> void:
	# Update SampledObjectRotatorNode
	object_rotator.set_rotation_from_sample(current_day_percentage)

	# Update LightColorTransitionNode
	light_transition.set_color_from_sample(current_day_percentage)
	
	light_intensity_transition_node.set_intensity_from_sample(current_day_percentage)

	# Update TimeHandler
	time_handler.set_time(total_time)
	
func process_time_changed(current_time: String):
	time_changed.emit(current_time)
