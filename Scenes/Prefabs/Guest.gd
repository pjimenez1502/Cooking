extends Node3D

var guest_face
var transparency
var starting_position = Vector3(5,0,-1)
var target_position = Vector3(1.5,0,-0.6)
var walking : bool

@onready var face_dictionary = {
	"MAN1": $Man1,
	"VAMPIRE": $Vampire,
	"SKELETON": $Skeleton,
}

func _ready():
	position = starting_position
	guest_face = face_dictionary[face_dictionary.keys()[randi_range(0, 2)]]
	guest_face.visible = true
	guest_face.transparency = 0.8
	walking = true

func _physics_process(delta):
	#if walking:
		#guest_face.transparency = clampf(guest_face.transparency + randf_range(-0.0005, 0.0005), 0.8, 1)
	#else:
		#guest_face.transparency = 1
		
	position = lerp(position, target_position, delta * 2)
	guest_face.transparency = lerp(guest_face.transparency, 1.0, delta*2)
	
	await get_tree().create_timer(1.5).timeout
	walking = false
