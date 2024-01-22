extends Node3D

func _on_stove_l_area_body_entered(body):
	if body is Pot or body is Pan:
		body.heated = true

func _on_stove_l_area_body_exited(body):
	if body is Pot or body is Pan:
		body.heated = false
