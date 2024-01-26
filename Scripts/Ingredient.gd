extends Grabable
class_name Ingredient

@export var id : FoodDictionary.IngredientID
var target_node
func _ready():
	gravity_scale = 0
	target_node = get_parent()
	compatible_areas.push_front("CUTTINGBOARD")

@export var cut_variant : PackedScene
var cut_progress := 0
func chop():
	
	if !cut_variant:
		return
	cut_progress += 1
	if cut_progress > 3:
		var instance = cut_variant.instantiate()
		instance.position = cooking_area.position
		target_node.add_child(instance)
		get_parent().remove_child(self)
