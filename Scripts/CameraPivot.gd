extends Node3D
class_name CameraPivot

const front_view_camera_rotation := 0.0
const top_view_camera_rotation := -40.0
const camera_rotation_speed := 3.0

enum VIEW {TOP, FRONT}
var current_view = VIEW.FRONT
var target_rotation = front_view_camera_rotation

func _process(delta):
	rotation.x = lerp(rotation.x, deg_to_rad(target_rotation), camera_rotation_speed * delta)
	pass

func switch_to_top_view():
	current_view = VIEW.TOP
	target_rotation = top_view_camera_rotation

func switch_to_front_view():
	current_view = VIEW.FRONT
	target_rotation = front_view_camera_rotation
