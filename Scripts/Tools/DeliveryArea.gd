extends CookingArea
class_name DeliveryArea

@export var delivery_slot : int
@onready var guest_manager = $"../../../../../Guest_manager"

func delivered(bowl):
	
	
	var bowl_ingredients = []
	for content in bowl.current_content:
		if bowl.current_content[content]["active"]:
			bowl_ingredients.push_back(content)
	
	
	print(guest_manager.guest_slots[delivery_slot]["guest"].choosen_meal)
	print(bowl_ingredients)
	##TODO: Compare lists to get score.   Make guest eat and pay.   release guest slot
	
