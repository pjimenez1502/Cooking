extends Grabable
class_name Plate

var current_ingredients: Array

var current_content = {
	"chopped_onion": {"active": false,},
	"chopped_carrot": {"active": false,},
	"chopped_tomato": {"active": false,},
	"chopped_mushroom": {"active": false,},
	"chopped_garlic": {"active": false,},
	#"green_leaves": {"active": false,},
	"sauteed_noodles": {"active": false,},
	
	"sauteed_onion": {"active": false,},
	"sauteed_carrot": {"active": false,},
	"sauteed_tomato": {"active": false,},
	"sauteed_mushroom": {"active": false,},
	"sauteed_garlic": {"active": false,},
	#"sauteed_green_leaves": {"active": false,},
	"fried_noodles": {"active": false,},
	
	"burned_onion": {"active": false,},
	"burned_carrot": {"active": false,},
	"burned_tomato": {"active": false,},
	"burned_mushroom": {"active": false,},
	"burned_garlic": {"active": false,},
	#"burned_green_leaves": {"active": false,},
	"burned_noodles": {"active": false,},
	
	"SOY": {"active": false},
}

@onready var content_refecences = {
	##CHOPPED
	"chopped_onion": {"object": $Pan_ingredients/Pan_Onion,},
	"chopped_carrot": {"object": $Pan_ingredients/Pan_Carrot,},
	"chopped_tomato": {"object": $Pan_ingredients/Pan_Tomato,},
	"chopped_mushroom": {"object": $Pan_ingredients/Pan_Mushrooms,},
	"chopped_garlic": {"object": $Pan_ingredients/Pan_Garlic,},
	#"green_leaves": {"object": "",},
	"cooked_noodles": {"object": $Pan_ingredients/Pan_Noodles,},
	
	##SAUTÉED
	"sauteed_onion": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Onion,},
	"sauteed_carrot": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Carrot,},
	"sauteed_tomato": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Tomato,},
	"sauteed_mushroom": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Mushrooms,},
	"sauteed_garlic": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Garlic,},
	#"sauteed_green_leaves": {"object": "",},
	"fried_noodles": {"object": $Sauteed_Pan_ingredients/Fried_Pan_Noodles,},
	
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

func plate_ingredients(ingredients: Array):
	for ingredient in ingredients:
		set_ingredient_active(ingredient, true)

func set_ingredient_active(content_key: String, active: bool):
		current_content[content_key]["active"] = active
		content_refecences[content_key]["object"].visible = active


