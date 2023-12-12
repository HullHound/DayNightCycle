extends Node3D

func _on_time_changed(current_time) -> void:
	$ClockLabel.text = str(current_time)
	
	if current_time == "06:00":
		$OmniLight3D.visible = false
	
	if current_time == "18:00":
		$OmniLight3D.visible = true
