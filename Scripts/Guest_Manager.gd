extends Node

@export var guest_prefab : PackedScene

var guest_slots = {
	0:{"available": true, "position": 1.3,},
	1:{"available": true, "position": 0.45,},
	2:{"available": true, "position": -0.45,},
	3:{"available": true, "position": -1.3,},
}
@onready var guests_parent = $"."

var time_between_spawns = 16
var guest_spawn_timer

func _ready():
	guest_spawn_timer = Timer.new()
	add_child(guest_spawn_timer)
	queue_guest_spawn()
	
func queue_guest_spawn():
	guest_spawn_timer.start(time_between_spawns)
	await guest_spawn_timer.timeout
	try_spawn_guest()
	
	queue_guest_spawn()

func try_spawn_guest():
	while check_available_slots():
		var position_to_check = randi_range(0, 3)
		if !guest_slots[position_to_check]["available"]:
			continue
		guest_slots[position_to_check]["available"] = false
		spawn_guest(position_to_check)
		return

func spawn_guest(slot : int):
	var instance = guest_prefab.instantiate()
	
	instance.slot = slot
	instance.target_position = Vector3(guest_slots[slot]["position"], 0, -0.7)
	guests_parent.add_child(instance)

func free_slot(slot : int): ## TODO: ON LEAVING, GUESTS MUST TELL MANAGER THAT THEIR SLOT IS NOW AVAILABLE TO USE
	guest_slots[slot]["available"] = true

func check_available_slots():
	for slot in guest_slots:
		if guest_slots[slot]["available"]:
			return true
	return false
