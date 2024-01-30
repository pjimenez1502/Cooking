extends Node3D

var transparency
var starting_position = Vector3(5,0,-1)
var target_position : Vector3
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

@onready var dialog_sprite = $Dialog/DialogSprite
@onready var meal_icon = $Dialog/DialogSprite/MealIcon
const MEAL_ICON_ROUTE = "res://Materials/Textures/UI/Meal_icons/"


func init_guest():
	position = starting_position
	clothes.texture = get_texture(clothes_dictionary)
	face.texture =  get_texture(faces_dictionary)
	
	face.visible = true
	face.transparency = 0.8
	dialog_sprite.visible = false
	
	meal_icon.texture = load(MEAL_ICON_ROUTE + choosen_meal["image"])
	
	await get_tree().create_timer(2 + 0.5 * slot).timeout
	on_spot_arrival()
	
func _physics_process(delta):
	#position = lerp(position, target_position, delta * 1)
	position = position.move_toward(target_position, delta * 2)
	face.transparency = lerp(face.transparency, 1.0, delta * 1)
	
	

func on_spot_arrival():
	dialog_sprite.visible = true
	dialog_sprite.play("default", randf_range(0.9, 1.1))
	

func evaluate_meal(bowl_ingredients, ingredients_stage):
	var meal_score = 5
	dialog_sprite.visible = false
	var target_ingredients = 0
	var leftover_ingredients = bowl_ingredients
	for ingredient in choosen_meal["ingredients"]:
		if bowl_ingredients.has(ingredient):
			leftover_ingredients.erase(ingredient)
			target_ingredients += 1
	
	##reduce score if missing ingredients or unrequested ingredients
	meal_score -= (choosen_meal["ingredients"].size() - target_ingredients) + leftover_ingredients.size()
	##reduce score if unkooked or overcooked ingredients
	for cook_stage in ingredients_stage:
		if cook_stage != 1:
			meal_score -=1
	
	#print(leftover_ingredients)
	#print(choosen_meal["ingredients"].size() ," - ",target_ingredients)
	#print(ingredients_stage)
	print (meal_score)
	pass
	
func pay_and_leave():
	pass

func get_texture(textures_dictionary: Dictionary) -> Texture2D:
	var key = textures_dictionary.keys()[randi_range(0, textures_dictionary.size()-1)]
	return load(textures_dictionary[key])
