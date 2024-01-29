extends Node3D

var transparency
var starting_position = Vector3(5,0,-1)
var target_position : Vector3
var walking : bool
var slot : int

@onready var clothes = $Clothes
@onready var face = $Face

@onready var faces_dictionary = {
	"SKELETON": "res://Materials/Textures/Guests/Faces/Guest_skeleton.png",
}
@onready var clothes_dictionary = {
	"Long_robes": "res://Materials/Textures/Guests/Clothes/Long_Robes.png"
}

var choosen_meal

func _ready():
	position = starting_position
	clothes.texture = get_texture(clothes_dictionary)
	face.texture =  get_texture(faces_dictionary)
	
	face.visible = true
	face.transparency = 0.8
	walking = true

func _physics_process(delta):
	#position = lerp(position, target_position, delta * 1)
	position = position.move_toward(target_position, delta * 2)
	face.transparency = lerp(face.transparency, 1.0, delta * 1)
	
	await get_tree().create_timer(1.5).timeout
	walking = false

func evaluate_meal():
	print("choosen meal: ", choosen_meal)
	pass

func get_texture(textures_dictionary: Dictionary) -> Texture2D:
	var key = textures_dictionary.keys()[randi_range(0, textures_dictionary.size()-1)]
	return load(textures_dictionary[key])
