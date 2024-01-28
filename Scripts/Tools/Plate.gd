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
	
	
}

func plate_ingredients(ingredients: Array):
	print(ingredients)			#RECEIVES list of ingredients.   	ON POT WATER - set
	for ingredient in ingredients:
		set_ingredient_active(ingredient, true)
		

func set_ingredient_active(content_key: String, active: bool):
		current_content[content_key]["active"] = active
		content_refecences[content_key]["object"].visible = active


