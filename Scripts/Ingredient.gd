extends Grabable

class_name Ingredient

var target_node
func _ready():
	target_node = get_parent()

@export var cut_variant : PackedScene
var cut_progress := 0
func chop():
	if !cut_variant:
		return
	cut_progress += 1
	if cut_progress > 3:
		var instance = cut_variant.instantiate()
		instance.position = position
		target_node.add_child(instance)
		get_parent().remove_child(self)
