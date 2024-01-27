extends AnimatableBody3D
class_name Grabable

var grabbed : bool
@export var grabbed_view : CameraPivot.VIEW
var target_height := 1.2
@export var target_z := 0.6
@export var compatible_areas : Array
var cooking_area : CookingArea
var current_rotation : Quaternion

@export var self_area_collider : CollisionShape3D

func _ready():
	compatible_areas.push_front("CENTERBOARD")
	pass # Replace with function body.

func _process(_delta):
	pass

func _physics_process(delta):
	if grabbed:
		current_rotation = Quaternion(transform.basis).slerp(Quaternion(), delta * 20.0)
		transform.basis = Basis(current_rotation)
	
func grab():
	grabbed = true
	match grabbed_view:
		CameraPivot.VIEW.TOP:
			position.y = target_height
		CameraPivot.VIEW.FRONT:
			position.z = target_z
	if cooking_area:
		print("aa")
		cooking_area.set_available(true)
		cooking_area = null
	if self_area_collider:
		self_area_collider.disabled = true
	
func release():
	grabbed = false
	if self_area_collider:
		self_area_collider.disabled = false


func set_hovered(value):
	pass
	#grabbed = false;
	#if !hovered_indicator:
		#return
	#hovered_indicator.visible = value
	
func use():
	pass

#func check_area_compatible(area_name : String):
	#print("AREA IS: ", area_name, " Compatible are: ", compatible_areas)
	#if compatible_areas.has(area_name):
		#return true
	#return false
