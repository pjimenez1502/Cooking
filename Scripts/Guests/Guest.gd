extends Node3D

var transparency
var starting_position = Vector3(0,0,-3)
var target_position : Vector3
var slot : int

var movement_speed = 1

var choosen_meal
var choosen_drink

var dialog

func init_guest():
	GuestDialogManager.on_guest_enter(self)
	
	position = starting_position
	await get_tree().create_timer(2 + 0.5 * slot).timeout
	on_spot_arrival()
	
	$Guest_3/AnimationPlayer.play("Idle")
	$Guest_2/AnimationPlayer.play("Idle")
	
	
func _physics_process(delta):
	#position = lerp(position, target_position, delta * 1)
	position = position.move_toward(target_position, delta * movement_speed)


func on_spot_arrival():
	GuestDialogManager.on_guest_arrived()
	

func evaluate_meal(bowl_ingredients, ingredients_stage):
	var meal_score = 5
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
	pay_and_leave()
	pass
	
func pay_and_leave():
	target_position = starting_position
	GuestDialogManager.on_guest_leave()
	pass

func get_texture(textures_dictionary: Dictionary) -> Texture2D:
	var key = textures_dictionary.keys()[randi_range(0, textures_dictionary.size()-1)]
	return load(textures_dictionary[key])

