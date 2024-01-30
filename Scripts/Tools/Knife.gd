extends Tool

var interaction_timer
var chopping := false

func _ready():
	super._ready()
	interaction_timer = Timer.new()
	add_child(interaction_timer)

func downswing():
	chopping = true 
	interaction_timer.start(0.4)
	await interaction_timer.timeout
	chopping = false

func _on_cut_area_body_entered(body):
	if !chopping:
		return
	if !body is Ingredient:
		return
	body.chop()

