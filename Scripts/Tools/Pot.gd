extends Cookware
class_name Pot

var empty_content_level = 0
var water_content_level = 0.75

@onready var pot_content_refecences = {
	
	"chopped_onion": {"object": $Pot_ingredients/Pan_Onion, 		"cook_time": 5,"result" : "sauteed_onion"},
	"chopped_carrot": {"object": $Pot_ingredients/Pan_Carrot, 		"cook_time": 5, "result" : "sauteed_carrot"},
	"chopped_tomato": {"object": $Pot_ingredients/Pan_Tomato, 		"cook_time": 5, "result" : "sauteed_tomato"},
	"chopped_mushroom": {"object": $Pot_ingredients/Pan_Mushroom, 	"cook_time": 5, "result" : "sauteed_mushroom"},
	"chopped_garlic": {"object": $Pot_ingredients/Pan_Garlic, 		"cook_time": 5, "result" : "sauteed_garlic"},
	"chopped_potato": {"object": $Pot_ingredients/Pan_Potato, 		"cook_time": 5, "result" : "sauteed_potato"},
	"meat": {"object": $Pot_ingredients/Pan_Meat, 		"cook_time": 5, "result" : "sauteed_meat"},
	
	"wine" : {"object": $Pot_ingredients/Wine,},
	"water" : {"object": $Pot_ingredients/Water,},
	"stew_water" : {"object": $Pot_ingredients/Stew_water,},
	"stew" : {"object": $Pot_ingredients/Stew,}
	
}

func _ready():
	#current_content = pot_current_content
	content_refecences = pot_content_refecences
	
	var pot_ingredients = $Pot_ingredients
	pot_ingredients.visible = true
	for ingredient in pot_ingredients.get_children():
		ingredient.visible = false
