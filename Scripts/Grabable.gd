extends RigidBody3D
class_name Grabable

@export var hovered_indicator : Node3D
var grabbed
@export var grabbed_view : CameraPivot.VIEW
var target_height := 1.2
var target_z := 0.6

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _physics_process(delta):
	#gravity_scale = 0 if grabbed else 1
	pass
	
func grab():
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
	#print(value)
	if !hovered_indicator:
		return
	hovered_indicator.visible = value
	
