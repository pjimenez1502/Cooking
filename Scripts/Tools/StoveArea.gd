extends Node3D


func _on_stove_l_area_body_entered(body):
	if body is Cookware:
		body.heated = true

func _on_stove_l_area_body_exited(body):
	if body is Cookware:
		body.heated = false
		
