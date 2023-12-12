## This script defines a Node that facilitates light_energy transitions for a 3D light using a curve.

extends Node

class_name LightIntensityTransitionNode

# Exposed variables
## The curve that determines how intense the light should be throughout the time frame
@export var intensity_curve : Curve = Curve.new()
## The target light to set the intensity of
@export var light : Light3D = null

## Set the light intensity based on the provided sample point
func set_intensity_from_sample(sample_point: float) -> void:
	light.light_energy = intensity_curve.sample_baked(sample_point)
