extends Node

const RECIPES_FILE = "res://Data/Recipes.json"
@export var guest_prefab : PackedScene
@onready var guests_parent = $"."

var time_between_spawns = 2
var guest_spawn_timer

var guest_slots = {
	0:{"available": true, "position": 0, "guest": null},
	
	
	#0:{"available": true, "position": 1.7, "guest": null},
	#1:{"available": true, "position": 0.6, "guest": null},
	#2:{"available": true, "position": -0.6, "guest": null},
	#3:{"available": true, "position": -1.7, "guest": null},
}


func _ready():
	guest_spawn_timer = Timer.new()
	add_child(guest_spawn_timer)
	queue_guest_spawn()
	load_recipes()
	
func queue_guest_spawn():
	guest_spawn_timer.start(time_between_spawns)
	await guest_spawn_timer.timeout
	try_spawn_guest()
	
	queue_guest_spawn()

func try_spawn_guest():
	while check_available_slots():
		var position_to_check = randi_range(0, guest_slots.size()-1)
		if !guest_slots[position_to_check]["available"]:
			continue
		guest_slots[position_to_check]["available"] = false
		var new_guest = spawn_guest(position_to_check)
		guest_slots[position_to_check]["guest"] = new_guest
		return

func spawn_guest(slot : int):
	var instance = guest_prefab.instantiate()
	
	instance.slot = slot
	instance.target_position = Vector3(guest_slots[slot]["position"], 0, -0.7)
	guests_parent.add_child(instance)
	instance.choosen_meal = choose_recipe()
	instance.init_guest()
	return instance

func free_slot(slot : int):
	guest_slots[slot]["available"] = true
	guest_slots[slot]["guest"] = null

func check_available_slots():
	for slot in guest_slots:
		if guest_slots[slot]["available"]:
			return true
	return false

var recipelist
func load_recipes():
	var RECIPES = FileAccess.open(RECIPES_FILE, FileAccess.READ)
	recipelist = JSON.parse_string(RECIPES.get_as_text())
	
func choose_recipe():
	var selected = recipelist.keys()[randi_range(0, recipelist.size() -1)]
	#print(recipelist[selected]["ingredients"])
	return recipelist[selected]
