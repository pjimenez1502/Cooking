extends Node3D
class_name CameraPivot

const table_view_camera_rotation := -45.0
const counter_view_camera_rotation := -10.0
const camera_rotation_speed := 2.0

#@onready var camera = $CameraPivot/Camera3D
@onready var camera = $CameraPivot/SubViewportContainer/SubViewport/Camera3D

const table_fov = 80.0
const counter_fov = 50.0
var fov_speed = 1.0

var target_rotation = table_view_camera_rotation
var target_fov = table_fov

func _process(delta):
	
	camera.rotation.x = lerp(camera.rotation.x, deg_to_rad(target_rotation), camera_rotation_speed * delta)
	camera.fov = lerp(camera.fov, target_fov, fov_speed * delta)
	pass


func _on_UP_button_pressed():
	target_rotation = counter_view_camera_rotation
	target_fov = counter_fov
	fov_speed = 2.0
	up_button.visible = false
	down_button.visible = true


func _on_DOWN_button_pressed():
	target_rotation = table_view_camera_rotation
	target_fov = table_fov
	fov_speed = 2.0
	up_button.visible = true
	down_button.visible = false
	
@onready var up_button = $"../UP_Button"
@onready var down_button = $"../DOWN_Button"
