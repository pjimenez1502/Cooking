extends Node3D
class_name CameraPivot

const table_fov = 80.0
const counter_fov = 50.0
const table_view_camera_rotation := -45.0
const counter_view_camera_rotation := -10.0
const camera_rotation_speed := 2.0

var fov_speed = 1.0

var up_button_enabled := false
var down_button_enabled := false

@onready var up_button = $"../UP_Button"
@onready var down_button = $"../DOWN_Button"
@onready var camera = $CameraPivot/SubViewportContainer/SubViewport/Camera3D


var target_rotation = table_view_camera_rotation
var target_fov = table_fov

func _init():
	GuestDialogManager.GuestArrived.connect(enable_up_button)
	GuestDialogManager.GuestLeft.connect(disable_up_button)
	GuestDialogManager.ConvoEnded.connect(enable_down_button)

func _process(delta):
	camera.rotation.x = lerp(camera.rotation.x, deg_to_rad(target_rotation), camera_rotation_speed * delta)
	camera.fov = lerp(camera.fov, target_fov, fov_speed * delta)


func _on_UP_button_pressed():
	trigger_counter_view()
	up_button.visible = false
	if down_button_enabled:
		down_button.visible = true

func _on_DOWN_button_pressed():
	trigger_table_view()
	if up_button_enabled:
		up_button.visible = true
	down_button.visible = false

func enable_up_button():
	up_button_enabled = true
	up_button.visible = true

func disable_up_button():
	up_button_enabled = false
	up_button.visible = false

func enable_down_button():
	down_button_enabled = true
	down_button.visible = true

func disable_down_button():
	down_button_enabled = false
	down_button.visible = false



func trigger_table_view():
	target_rotation = table_view_camera_rotation
	target_fov = table_fov
	fov_speed = 2.0
	
func trigger_counter_view():
	target_rotation = counter_view_camera_rotation
	target_fov = counter_fov
	fov_speed = 2.0
	
	if GuestDialogManager.next_convo:
		disable_down_button()
		await get_tree().create_timer(1).timeout
		GuestDialogManager.show_dialog()
