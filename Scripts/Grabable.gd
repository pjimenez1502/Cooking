extends RigidBody3D
class_name Grabable

@export var hovered_indicator : Node3D
var grabbed
@export var grabbed_view : CameraPivot.VIEW
var target_height := 1.2
@export var target_z := 0.6

var current_rotation : Quaternion

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func _physics_process(delta):
	if grabbed:
		current_rotation = Quaternion(transform.basis).slerp(Quaternion(), delta * 20.0)
		transform.basis = Basis(current_rotation)
	
func grab():
	grabbed = true;
	gravity_scale = 0
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	match grabbed_view:
		CameraPivot.VIEW.TOP:
			position.y = target_height
		CameraPivot.VIEW.FRONT:
			position.z = target_z

func release():
	gravity_scale = 1

func set_hovered(value):
	grabbed = false;
	if !hovered_indicator:
		return
	hovered_indicator.visible = value
	
func use():
	pass
