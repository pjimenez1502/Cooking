extends Cookware
class_name Pot

@onready var pot_content_refecences = {
	
	##STEWIE
	"stew_base": {"object": $POT_Contents/STEW_Base,			"cook_time": 5, "result" : "burned_onion"},
	"stew_meat": {"object": $POT_Contents/STEW_Meat,			"cook_time": 5, "result" : "burned_onion"},
	"stew_carrot": {"object": $POT_Contents/STEW_Carrot, 		"cook_time": 5, "result" : "burned_carrot"},
	"stew_potato": {"object": $POT_Contents/STEW_Potato, 		"cook_time": 5, "result" : "burned_tomato"},
	
	##Finished
	"stew_finished": {"object": $POT_Contents/STEW_Finished, }
}

func _ready():
	#current_content = pot_current_content
	content_refecences = pot_content_refecences
