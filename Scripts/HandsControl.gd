extends Camera3D

@onready var camera_pivot = $".."
var mouse = Vector2()
var grabbed: Grabable

var prev_mouse_position #TODO: DELETE
var next_mouse_position #TODO: DELETE

func _ready():
	pass

func _physics_process(delta):
	grabbed_movement(delta)

func _input(event):
	if event is InputEventMouse:
		mouse = event.position
	
	if event.is_action_pressed("LeftClick"):
		check_grab_ingredientsack()
		
		if !grabbed:
			try_grabbing()
			return
		if hovered_mousearea and hovered_mousearea.check_area_compatible(grabbed.compatible_areas):
			release_grabbed(hovered_mousearea)
	
	if event.is_action_pressed("RightClick"):
		if grabbed:
			grabbed.use()



func check_grab_ingredientsack():
	prev_mouse_position = get_viewport().get_mouse_position() ##check
	
	var ingredientsack_area = screen_point_to_ray(0b100) # LAYER 3 (IngredientSacks)
	if ingredientsack_area:
		if !grabbed:
			grabbed = ingredientsack_area["collider"].get_parent().instantiate_ingredient()
			return
		if grabbed is Ingredient:
			delete_grabbed()

func try_grabbing():
	var grabbable_collision = screen_point_to_ray(0b100000) # LAYER 6 (GRABBABLES)
	if grabbable_collision:
		grabbed = grabbable_collision["collider"].get_parent()
		grabbed.grab()
		#print("Grabbing: ", grabbed.name)



func release_grabbed(hovered_mousearea):
	#print("Releasing: ", grabbed.name)
	if hovered_mousearea is CookwareArea:
		hovered_mousearea.get_parent().add_ingredient(grabbed.id)
		#grabbed.release()
		grabbed.queue_free()
		grabbed = null
		return
	
	if hovered_mousearea is DeliveryArea:
		
		grabbed.release()
		hovered_mousearea.delivered(grabbed)
		
	hovered_mousearea.set_available(false)
	grabbed.global_position = hovered_mousearea.global_position
	grabbed.cooking_area = hovered_mousearea
	grabbed.release()
	grabbed = null
	
	#switch_view(CameraPivot.VIEW.FRONT)
	
func delete_grabbed():
	grabbed.queue_free()
	grabbed = null

var hovered_mousearea
func grabbed_movement(delta):
	if !grabbed:
		return
	grabbed.position = screen_point_to_ray(0b1000).position # LAYER 4 (MOUSEPLANE)
	
	var mouse_area_collision = screen_point_to_ray(0b10000) # LAYER 5 (MOUSEAREAS)
	if mouse_area_collision:
		hovered_mousearea = mouse_area_collision["collider"]
		if hovered_mousearea.check_area_compatible(grabbed.compatible_areas):
		#if grabbed.check_area_compatible(hovered_mousearea.name) and hovered_mousearea.available:
			grabbed.global_position = hovered_mousearea.global_position + Vector3(0, 0.1, 0)
	else:
		hovered_mousearea = null

	next_mouse_position = get_viewport().get_mouse_position()
	var mouse_speed = next_mouse_position - prev_mouse_position
	check_mouse_swings(mouse_speed)
	
	prev_mouse_position = next_mouse_position



const Swing_Speed_Threshold := 50.0
enum SwingStates{ DOWN, UP, RIGHT, LEFT, NEUTRAL}
var currentSwing := SwingStates.NEUTRAL
func check_mouse_swings(mouse_speed:Vector2):
	if !grabbed is Tool:
		return
	if (mouse_speed.y > Swing_Speed_Threshold):
		if !currentSwing == SwingStates.DOWN:
			#print("DOWNSWING")
			grabbed.downswing()
			currentSwing = SwingStates.DOWN
	elif (mouse_speed.y < -Swing_Speed_Threshold):
		if !currentSwing == SwingStates.UP:
			#print("UPSWING")
			grabbed.upswing()
			currentSwing = SwingStates.UP
	elif (mouse_speed.x > Swing_Speed_Threshold):
		if !currentSwing == SwingStates.RIGHT:
			#print("RIGHTSWING")
			grabbed.rightswing()
			currentSwing = SwingStates.RIGHT
	elif (mouse_speed.x < -Swing_Speed_Threshold):
		if !currentSwing == SwingStates.LEFT:
			grabbed.leftswing()
			#print("LEFTSWING")
			currentSwing = SwingStates.LEFT
	else:
		currentSwing = SwingStates.NEUTRAL



func screen_point_to_ray(layer_mask) -> Dictionary:
	
	var spaceState = get_world_3d().direct_space_state
	
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	var ray_origin = camera.project_ray_origin(mousePos)
	var ray_end = ray_origin + camera.project_ray_normal(mousePos) * 1000
	
	var rayQuery = PhysicsRayQueryParameters3D.create(ray_origin, ray_end, layer_mask)
	rayQuery.collide_with_areas = true
	var mouse_ray = spaceState.intersect_ray(rayQuery)
	
	if mouse_ray.has("position"):
		#print("HIT: ", mouse_ray["collider"], " - ",mouse_ray["collider"].get_collision_layer())
		return mouse_ray
	return {}

