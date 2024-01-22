extends Grabable
class_name Pourable

@export var pourable_type : FoodDictionary.POURABLE_TYPE
@onready var pourable_area = $PourableArea

func use():
	pour()
	
func pour():
	for body in pourable_area.get_overlapping_bodies():
		if body is Pot or body is Pan:
			if body.add_pourable(pourable_type):
				## PLAY POURING ANIMATION
				pass
