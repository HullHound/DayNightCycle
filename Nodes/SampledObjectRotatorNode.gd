## This script defines a Node that rotates a target Node3D based on sampled curves.

extends Node

class_name SampledObjectRotatorNode

# Exposed variables
## The curve that describes the X rotation of the target in degrees at the associated sample points
@export var x_rotation_curve : Curve = Curve.new()
## The curve that describes the Y rotation of the target in degrees at the associated sample points
@export var y_rotation_curve : Curve = Curve.new()
## The curve that describes the Z rotation of the target in degrees at the associated sample points
@export var z_rotation_curve : Curve = Curve.new()

## The node that will be rotated based on the rotation curves based on the associated sample point
@export var target_node : Node3D = null

## Set the rotation of the target node based on the provided sample point
func set_rotation_from_sample(sample_point: float) -> void:
	var rotation = Vector3(
		x_rotation_curve.sample_baked(sample_point),
		y_rotation_curve.sample_baked(sample_point),
		z_rotation_curve.sample_baked(sample_point)
	)
	target_node.rotation_degrees = rotation
