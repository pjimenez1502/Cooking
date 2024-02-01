extends CookingArea
class_name DeliveryArea

@export var delivery_slot : int
@onready var guest_manager = $"../../../Guest_manager"


func delivered(bowl):
	
	var bowl_ingredients = []
	var ingredients_stage = []
	
	for content in bowl.current_content:
		if bowl.current_content[content]["active"]:
			bowl_ingredients.push_back(content)
			ingredients_stage.push_back(bowl.current_content[content]["cook_stage"])
	
	
	
	await get_tree().create_timer(2).timeout
	available = true
	bowl.queue_free()
	guest_manager.guest_slots[delivery_slot]["guest"].evaluate_meal(bowl_ingredients, ingredients_stage)
	
	
	##TODO: Compare lists to get score.   Make guest eat and pay.   release guest slot
	
