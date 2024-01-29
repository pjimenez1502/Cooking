extends Pourable
class_name Cookware

var heated := false
@onready var ingredients = $Ingredients
var cookware_speed = 1

const RAW_SHADER = preload("res://Materials/Mats/Ingredients.tres")
const SAUTEED_SHADER = preload("res://Materials/Mats/SauteedIngredients.tres")
const BURNED_SHADER = preload("res://Materials/Mats/BurnedIngredients.tres")

func _physics_process(delta):
	super._physics_process(delta)
	progress_cooking(delta) #TODO: REENABLE

func _ready():
	ready_ingredients()

@onready var current_content = {
	"chopped_onion": 	{"active": false, "cook_time": 0, "cook_stage": 0 },
	"chopped_carrot": 	{"active": false, "cook_time": 0, "cook_stage": 0 },
	"chopped_tomato": 	{"active": false, "cook_time": 0, "cook_stage": 0 },
	"chopped_mushroom": {"active": false, "cook_time": 0, "cook_stage": 0 },
	"chopped_garlic": 	{"active": false, "cook_time": 0, "cook_stage": 0 },
	"chopped_potato": 	{"active": false, "cook_time": 0, "cook_stage": 0 },
	"meat": 			{"active": false, "cook_time": 0, "cook_stage": 0 },
	#"green_leaves": {"active": false, "cook_time": 0},

	"water": {"active": false},
	"wine": {"active": false},
}
@onready var content_references = {
	"chopped_onion": {"object": $Ingredients/Onion, 		"cook_multiplier": 10 },
	"chopped_carrot": {"object": $Ingredients/Carrot, 		"cook_multiplier": 10 },
	"chopped_tomato": {"object": $Ingredients/Tomato, 		"cook_multiplier": 10 },
	"chopped_mushroom": {"object": $Ingredients/Mushroom, 	"cook_multiplier": 10 },
	"chopped_garlic": {"object": $Ingredients/Garlic, 		"cook_multiplier": 10 },
	"chopped_potato": {"object": $Ingredients/Potato, 		"cook_multiplier": 10 },
	"meat": 		{"object": $Ingredients/Meat, 			"cook_multiplier": 5 },
	
	
	"wine" : {"object": $Ingredients/Wine,},
	"water" : {"object": $Ingredients/Water,},
	"stew" : {"object": $Ingredients/Stew,}
}

func use():
	pour_ingredients()

func add_ingredient(ingredient_reference):
	print("ADDING INGREDIENT: ", FoodDictionary.IngredientID.keys()[ingredient_reference])
	for content_key in content_references:
		if content_key == FoodDictionary.IngredientID.keys()[ingredient_reference]:
			if current_content[content_key]["active"]:
				return
			set_ingredient_active(content_key, true, 0)

@onready var cook_particle = $Cooked_particle

func progress_cooking(delta):
	if !heated:
		return
	for content_key in current_content:
		if !current_content[content_key]["active"] or !content_references[content_key].has("cook_multiplier"): ## NOT ACTIVE OR CANT BE COOKED
			continue
			
		if current_content[content_key]["cook_stage"] == 2:
			continue
		
		current_content[content_key]["cook_time"] += (delta * content_references[content_key]["cook_multiplier"] * cookware_speed)
		print(current_content[content_key]["cook_time"])
		if current_content[content_key]["cook_time"] >= 100:
			match current_content[content_key]["cook_stage"]:
				0:
					content_references[content_key]["object"].mesh.surface_set_material(0, SAUTEED_SHADER)
					current_content[content_key]["cook_time"] = 0
					current_content[content_key]["cook_stage"] += 1
					cook_particle.emitting = true
				1:
					content_references[content_key]["object"].mesh.surface_set_material(0, BURNED_SHADER)
					current_content[content_key]["cook_stage"] += 1
					cook_particle.emitting = true
				2:
					cook_particle.emitting = true
			
			


func add_pourable(_pour : FoodDictionary.POURABLE_TYPE):
	#print(FoodDictionary.POURABLE_TYPE.keys()[_pour])
	for content_key in current_content:
		if content_key == FoodDictionary.POURABLE_TYPE.keys()[_pour]:
			if current_content[content_key]["active"]:
				return false ## If already contains this, return false so pouring animation does not play
			set_ingredient_active(content_key, true, 0)
			return true

func pour_ingredients():
	for body in pourable_area.get_overlapping_bodies():
		if body is Plate:
			var ingredient_list : Array
			for content_key in current_content:
				if current_content[content_key]["active"]:
					ingredient_list.push_front(content_key)
					set_ingredient_active(content_key, false, current_content[content_key]["cook_stage"])
			body.plate_ingredients(ingredient_list)
		if body is Cookware:
			var ingredient_list : Array
			for content_key in current_content:
				if current_content[content_key]["active"]:
					ingredient_list.push_front(content_key)
					set_ingredient_active(content_key, false, current_content[content_key]["cook_stage"])
					body.set_ingredient_active(content_key, true, current_content[content_key]["cook_stage"])

func ready_ingredients():
	ingredients.visible = true
	for ingredient in ingredients.get_children():
		ingredient.visible = false

func set_ingredient_active(content_key: String, active: bool, cook_stage: int):
	current_content[content_key]["cook_stage"] = cook_stage
	current_content[content_key]["cook_time"] = 0
	current_content[content_key]["active"] = active
	content_references[content_key]["object"].visible = active
