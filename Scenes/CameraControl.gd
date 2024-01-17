extends Camera3D

@onready var camera_pivot = $".."
var mouse = Vector2()
var hovered: Grabable
var grabbing := false


var prev_mouse_position
var next_mouse_position

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	check_hover()
	grabbed_movement(delta)

func _input(event):
	if event is InputEventMouse:
		mouse = event.position
	if !hovered:
		return
	if event.is_action_pressed("LeftClick"):
		prev_mouse_position = get_viewport().get_mouse_position()
		grab_hovered()
	if Input.is_action_just_released("LeftClick"):
		release_grabbed()

func check_hover():
	if grabbing:
		return
	
	var worldspace = get_world_3d().direct_space_state
	var start = project_ray_origin(mouse)
	var end = project_position(mouse, 1000)
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	
	if !result || !result.collider:
		clearHovered()
		return
	if !result.collider is Grabable:
		clearHovered()
		return
		
	if result.collider == hovered:
		return
		
	if result.collider is Grabable:
		clearHovered()
		hovered = result.collider
		result.collider.set_hovered(true)
		
func clearHovered():
	if hovered:
		hovered.release()
		hovered.set_hovered(false)
		hovered = null

func grab_hovered():
	if !hovered:
		return
	switch_view(hovered.grabbed_view)
	hovered.grab()
	grabbing = true
	pass

func release_grabbed():
	hovered.release()
	grabbing = false
	switch_view(CameraPivot.VIEW.FRONT)

func grabbed_movement(delta):
	if !grabbing:
		return
		
	next_mouse_position = get_viewport().get_mouse_position()
	hovered.position.x += ((next_mouse_position.x - prev_mouse_position.x) * .1 * delta)
	match camera_pivot.current_view:
		CameraPivot.VIEW.TOP:
			hovered.position.z += ((next_mouse_position.y - prev_mouse_position.y) * .1 * delta)
		CameraPivot.VIEW.FRONT:
			hovered.position.y -= ((next_mouse_position.y - prev_mouse_position.y) * .1 * delta)
	
	
	prev_mouse_position = next_mouse_position

func switch_view(view:CameraPivot.VIEW):
	
	match view:
		CameraPivot.VIEW.TOP:
			print("viewTOP")
			camera_pivot.switch_to_top_view()
		CameraPivot.VIEW.FRONT:
			camera_pivot.switch_to_front_view()
