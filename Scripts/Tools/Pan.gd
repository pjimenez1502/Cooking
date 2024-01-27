extends Cookware
class_name Pan

@onready var pan_content_refecences = {
	##CHOPPED
	"chopped_onion": {"object": $Pan_ingredients/Pan_Onion, 		"cook_time": 5,"result" : "sauteed_onion"},
	"chopped_carrot": {"object": $Pan_ingredients/Pan_Carrot, 		"cook_time": 5, "result" : "sauteed_carrot"},
	"chopped_tomato": {"object": $Pan_ingredients/Pan_Tomato, 		"cook_time": 5, "result" : "sauteed_tomato"},
	"chopped_mushroom": {"object": $Pan_ingredients/Pan_Mushroom, 	"cook_time": 5, "result" : "sauteed_mushroom"},
	"chopped_garlic": {"object": $Pan_ingredients/Pan_Garlic, 		"cook_time": 5, "result" : "sauteed_garlic"},
	"chopped_potato": {"object": $Pan_ingredients/Pan_Potato, 		"cook_time": 5, "result" : "sauteed_potato"},
	"meat": {"object": $Pan_ingredients/Pan_Meat, 		"cook_time": 5, "result" : "sauteed_meat"},
	#"green_leaves": {"object": "", 								"cook_time": 5, "result" : "sauteed_green_leaves"},
	#"cooked_noodles": {"object": $Pan_ingredients/Pan_Noodles, 		"cook_time": 5, "result" : "fried_noodles"},
	
	###SAUTÉED
	#"sauteed_onion": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Onion,			"cook_time": 5, "result" : "burned_onion"},
	#"sauteed_carrot": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Carrot, 		"cook_time": 5, "result" : "burned_carrot"},
	#"sauteed_tomato": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Tomato, 		"cook_time": 5, "result" : "burned_tomato"},
	#"sauteed_mushroom": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Mushrooms, 	"cook_time": 5, "result" : "burned_mushroom"},
	#"sauteed_garlic": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Garlic, 		"cook_time": 5, "result" : "burned_garlic"},
	##"sauteed_green_leaves": {"object": "", 										"cook_time": 5, "result" : "burned_green_leaves"},
	##"fried_noodles": {"object": $Sauteed_Pan_ingredients/Fried_Pan_Noodles, 		"cook_time": 5, "result" : "burned_noodles"},
	#
	###BURNED
	#"burned_onion": {"object": $Burned_Pan_ingredients/Burned_Pan_Onion,},
	#"burned_carrot": {"object": $Burned_Pan_ingredients/Burned_Pan_Carrot,},
	#"burned_tomato": {"object": $Burned_Pan_ingredients/Burned_Pan_Tomato,},
	#"burned_mushroom": {"object": $Burned_Pan_ingredients/Burned_Pan_Mushrooms,},
	#"burned_garlic": {"object": $Burned_Pan_ingredients/Burned_Pan_Garlic,},
	##"burned_green_leaves": {"object": $Burned_Pan_ingredients/Burned_Pan_,},
	##"burned_noodles": {"object": $Burned_Pan_ingredients/Burned_Pan_Noodles,},
	
	#"SOY": {"object": $Pan_ingredients/Pan_SoySauce,},
}

func _ready():
	
	var pan_ingredients = $Pan_ingredients
	pan_ingredients.visible = true
	for ingredient in pan_ingredients.get_children():
		ingredient.visible = false
		
	#current_content = pan_current_content
	content_refecences = pan_content_refecences




