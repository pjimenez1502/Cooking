extends Node3D
class_name IngredientSack

@export var hovered_indicator : Node3D

enum Ingredients { TOMATO, CARROT, ONION, POTATO, MUSHROOM, MEAT, BOWL }
@export var sack_ingredient : Ingredients
var ingredient_dict = {
	"TOMATO" : "res://Scenes/Prefabs/Ingredients/Raw/Tomato.tscn",
	"CARROT" : "res://Scenes/Prefabs/Ingredients/Raw/Carrot.tscn",
	"ONION" : "res://Scenes/Prefabs/Ingredients/Raw/Onion.tscn",
	"POTATO" : "res://Scenes/Prefabs/Ingredients/Raw/Potato.tscn",
	"MUSHROOM": "res://Scenes/Prefabs/Ingredients/Raw/Mushroom.tscn",
	"MEAT": "res://Scenes/Prefabs/Ingredients/Raw/Meat.tscn",
	
	"BOWL": "res://Scenes/Prefabs/Tools/Grabbables/Bowl.tscn",
}

var ingredient_prefab
var target_node

func _ready():
	target_node = $"../../Interactuable"
	initialize_sack()
	pass

func initialize_sack():
	# SET INGREDIENT MODEL
	# SET PREFAB TO LOAD
	ingredient_prefab = load(ingredient_dict[Ingredients.keys()[sack_ingredient]])

func set_hovered(value):
	if !hovered_indicator:
		return
	hovered_indicator.visible = value


var instantiate_position = Vector3(0.0, 1.2, 0.6) # TODO: CHANGE TO CURRENT CURSOR 3D POSITION
func instantiate_ingredient():
	var instance = ingredient_prefab.instantiate()
	instance.position = instantiate_position
	target_node.add_child(instance)
	instance.grab()
	return instance
