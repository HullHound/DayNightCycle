## This script defines a Node that facilitates color transitions for a 3D light using a gradient.

extends Node

class_name LightColorTransitionNode

# Exposed variables
## The Light to set the color for
@export var light : Light3D = null

## The colour to assign to the light when the set_color function is called
@export var color_gradient : Gradient = Gradient.new()


## Sets the color of the light based on the provided sample point and the gradient
func set_color_from_sample(sample_point: float):
	light.light_color = color_gradient.sample(sample_point)
