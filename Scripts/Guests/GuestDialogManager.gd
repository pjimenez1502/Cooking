extends Node

signal GuestArrived
signal GuestLeft
signal ConvoEnded

var balloon
var next_convo

var selected_meal : String
var selected_drink : String

func _init():
	DialogueManager.dialogue_ended.connect(dialogue_ended)
	
func show_dialog():
	balloon = DialogueManager.show_dialogue_balloon(load("res://Dialogue/Guest_dialog.dialogue"), next_convo)
	next_convo = null

func dialogue_ended(res):
	ConvoEnded.emit()
	
func wants_drink():
	return selected_drink != ""


func on_guest_enter(guest):
	selected_meal = guest.choosen_meal["name"]
	if selected_drink:
		selected_drink = guest.choosen_drink

func on_guest_arrived():
	next_convo = "meal_request"
	GuestArrived.emit()

func on_guest_leave():
	GuestLeft.emit()
	pass

