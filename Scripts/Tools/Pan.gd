extends Pourable
class_name Pan

var heated := false

func _physics_process(delta):
	super._physics_process(delta)
	progress_cooking(delta)
	
var current_content = {
	"chopped_onion": {"active": false, "cook_time": 0 },
	"chopped_carrot": {"active": false, "cook_time": 0 },
	"chopped_tomato": {"active": false, "cook_time": 0 },
	"chopped_mushroom": {"active": false, "cook_time": 0 },
	"chopped_garlic": {"active": false, "cook_time": 0 },
	#"green_leaves": {"active": false, "cook_time": 0},
	"sauteed_noodles": {"active": false, "cook_time": 0},
	
	"sauteed_onion": {"active": false, "cook_time": 0 },
	"sauteed_carrot": {"active": false, "cook_time": 0 },
	"sauteed_tomato": {"active": false, "cook_time": 0 },
	"sauteed_mushroom": {"active": false, "cook_time": 0 },
	"sauteed_garlic": {"active": false, "cook_time": 0 },
	#"sauteed_green_leaves": {"active": false, "cook_time": 0},
	"fried_noodles": {"active": false, "cook_time": 0},
	
	"burned_onion": {"active": false, "cook_time": 0 },
	"burned_carrot": {"active": false, "cook_time": 0 },
	"burned_tomato": {"active": false, "cook_time": 0 },
	"burned_mushroom": {"active": false, "cook_time": 0 },
	"burned_garlic": {"active": false, "cook_time": 0 },
	#"burned_green_leaves": {"active": false, "cook_time": 0},
	"burned_noodles": {"active": false, "cook_time": 0},
	
	"SOY": {"active": false},
}

@onready var content_refecences = {
	##CHOPPED
	"chopped_onion": {"object": $Pan_ingredients/Pan_Onion, 		"cook_time": 5,"result" : "sauteed_onion"},
	"chopped_carrot": {"object": $Pan_ingredients/Pan_Carrot, 		"cook_time": 5, "result" : "sauteed_carrot"},
	"chopped_tomato": {"object": $Pan_ingredients/Pan_Tomato, 		"cook_time": 5, "result" : "sauteed_tomato"},
	"chopped_mushroom": {"object": $Pan_ingredients/Pan_Mushrooms, 	"cook_time": 5, "result" : "sauteed_mushroom"},
	"chopped_garlic": {"object": $Pan_ingredients/Pan_Garlic, 		"cook_time": 5, "result" : "sauteed_garlic"},
	#"green_leaves": {"object": "", 								"cook_time": 5, "result" : "sauteed_green_leaves"},
	"cooked_noodles": {"object": $Pan_ingredients/Pan_Noodles, 		"cook_time": 5, "result" : "fried_noodles"},
	
	##SAUTÉED
	"sauteed_onion": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Onion,			"cook_time": 5, "result" : "burned_onion"},
	"sauteed_carrot": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Carrot, 		"cook_time": 5, "result" : "burned_carrot"},
	"sauteed_tomato": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Tomato, 		"cook_time": 5, "result" : "burned_tomato"},
	"sauteed_mushroom": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Mushrooms, 	"cook_time": 5, "result" : "burned_mushroom"},
	"sauteed_garlic": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Garlic, 		"cook_time": 5, "result" : "burned_garlic"},
	#"sauteed_green_leaves": {"object": "", 										"cook_time": 5, "result" : "burned_green_leaves"},
	"fried_noodles": {"object": $Sauteed_Pan_ingredients/Fried_Pan_Noodles, 		"cook_time": 5, "result" : "burned_noodles"},
	
	##BURNED
	"burned_onion": {"object": $Burned_Pan_ingredients/Burned_Pan_Onion,},
	"burned_carrot": {"object": $Burned_Pan_ingredients/Burned_Pan_Carrot,},
	"burned_tomato": {"object": $Burned_Pan_ingredients/Burned_Pan_Tomato,},
	"burned_mushroom": {"object": $Burned_Pan_ingredients/Burned_Pan_Mushrooms,},
	"burned_garlic": {"object": $Burned_Pan_ingredients/Burned_Pan_Garlic,},
	#"burned_green_leaves": {"object": $Burned_Pan_ingredients/Burned_Pan_,},
	"burned_noodles": {"object": $Burned_Pan_ingredients/Burned_Pan_Noodles,},
	
	"SOY": {"object": $Pan_ingredients/Pan_SoySauce,},
}

func _on_ingredient_capture_body_entered(body):
	if !body is Ingredient:
		return
	var body_content_key = FoodDictionary.IngredientID.keys()[body.id]

	for content_key in content_refecences:
		if content_key == body_content_key:
			if current_content[content_key]["active"]:
				return
			set_ingredient_active(content_key, true)
			body.queue_free()

func add_pourable(pour : FoodDictionary.POURABLE_TYPE):
	#print(FoodDictionary.POURABLE_TYPE.keys()[pour])
	for content_key in current_content:
		if content_key == FoodDictionary.POURABLE_TYPE.keys()[pour]:
			if current_content[content_key]["active"]:
				return false ## If already contains this, return false so pouring animation does not play
			set_ingredient_active(content_key, true)
			return true

func progress_cooking(delta):
	if !heated:
		return
	for content_key in current_content:
		if !current_content[content_key]["active"]:
			continue
		if !content_refecences[content_key].has("cook_time"):
			continue
			
		current_content[content_key]["cook_time"] += delta
		if current_content[content_key]["cook_time"] >= content_refecences[content_key]["cook_time"]:
			set_ingredient_active(content_key, false)
			
			var cookresult = content_refecences[content_key]["result"]
			set_ingredient_active(cookresult, true)

func pour():
	for body in pourable_area.get_overlapping_bodies():
		if body is Plate:
			var ingredient_list : Array
			for content_key in current_content:
				if current_content[content_key]["active"]:
					ingredient_list.push_back(content_key)
					set_ingredient_active(content_key, false)
			body.plate_ingredients(ingredient_list)



func set_ingredient_active(content_key: String, active: bool):
		current_content[content_key]["active"] = active
		content_refecences[content_key]["object"].visible = active
