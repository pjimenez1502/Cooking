extends Node3D



func _on_stove_l_area_body_entered(body):
	print("entered: ",body)
	if body is Cookware:
		body.heated = true

func _on_stove_l_area_body_exited(body):
	print("exited: ",body)
	if body is Cookware:
		body.heated = false
		
