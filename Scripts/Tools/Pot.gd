extends Cookware
class_name Pot

@onready var pot_content_refecences = {
	##CHOPPED
	"chopped_potato": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Onion,			"cook_time": 5, "result" : "burned_onion"},
	
	##SAUTÉED
	"sauteed_onion": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Onion,			"cook_time": 5, "result" : "burned_onion"},
	"sauteed_carrot": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Carrot, 		"cook_time": 5, "result" : "burned_carrot"},
	"sauteed_tomato": {"object": $Sauteed_Pan_ingredients/Sauteed_Pan_Tomato, 		"cook_time": 5, "result" : "burned_tomato"},
}

func _ready():
	#current_content = pot_current_content
	content_refecences = pot_content_refecences
