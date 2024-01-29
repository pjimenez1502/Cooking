extends Cookware
class_name Pot

var empty_content_level = 0
var water_content_level = 0.065

func _ready():
	super._ready()
	cookware_speed = 0.1
	
func check_water_level():
	if current_content["water"]["active"] or current_content["wine"]["active"]:
		ingredients.position.y = water_content_level
	else:
		ingredients.position.y = empty_content_level

func add_pourable(_pour : FoodDictionary.POURABLE_TYPE):
	super.add_pourable(_pour)
	check_water_level()
	
