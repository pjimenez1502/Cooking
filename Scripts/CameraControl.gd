extends Camera3D

@onready var camera_pivot = $".."
var mouse = Vector2()
var hovered: Grabable
var grabbed: Grabable

var prev_mouse_position #TODO: DELETE
var next_mouse_position #TODO: DELETE

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	check_hover()
	grabbed_movement(delta)



func _input(event):
	if event is InputEventMouse:
		mouse = event.position
	
	if event.is_action_pressed("LeftClick"):
		if !grabbed:
			check_grab_ingredientsack()
			
			prev_mouse_position = get_viewport().get_mouse_position()
			grab_hovered()
		elif hovered_mousearea and hovered_mousearea.check_area_compatible(grabbed.compatible_areas):
			release_grabbed(hovered_mousearea)
	
	
	if event.is_action_pressed("RightClick"):
		if grabbed:
			grabbed.use()

func check_hover():
	if grabbed:
		return
	
	var worldspace = get_world_3d().direct_space_state
	var start = project_ray_origin(mouse)
	var end = project_position(mouse, 1000)
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end, 1))
	
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
	grabbed = hovered
	hovered.grab()
	#switch_view(hovered.grabbed_view)

func release_grabbed(hovered_mousearea):
	if hovered_mousearea is CookwareArea:
		hovered_mousearea.get_parent().add_ingredient(grabbed.id)
		#grabbed.release()
		grabbed.queue_free()
		hovered = null
		grabbed = null
		return
		
	hovered_mousearea.set_available(false)
	grabbed.cooking_area = hovered_mousearea
	grabbed.release()
	hovered = null
	grabbed = null
	
	
	#switch_view(CameraPivot.VIEW.FRONT)

var hovered_mousearea
func grabbed_movement(delta):
	if !grabbed:
		return
	grabbed.position = screen_point_to_ray(1000).position
	
	var mouse_area_collision = screen_point_to_ray(10000) # LAYER 5 (MOUSEAREAS)
	if mouse_area_collision:
		hovered_mousearea = mouse_area_collision["collider"]
		if hovered_mousearea.check_area_compatible(grabbed.compatible_areas):
		#if grabbed.check_area_compatible(hovered_mousearea.name) and hovered_mousearea.available:
			grabbed.global_position = hovered_mousearea.global_position
	else:
		hovered_mousearea = null

	next_mouse_position = get_viewport().get_mouse_position()
	var mouse_speed = next_mouse_position - prev_mouse_position
	check_mouse_swings(mouse_speed)
	
	prev_mouse_position = next_mouse_position

func check_grab_ingredientsack():
	var ingredientsack_area = screen_point_to_ray(000100) # LAYER 3
	if ingredientsack_area:
		#print(ingredientsack_area["collider"])
		grabbed = ingredientsack_area["collider"].get_parent().instantiate_ingredient()


const Swing_Speed_Threshold := 50.0
enum SwingStates{ DOWN, UP, RIGHT, LEFT, NEUTRAL}
var currentSwing := SwingStates.NEUTRAL
func check_mouse_swings(mouse_speed:Vector2):
	if !hovered is Tool:
		return
	if (mouse_speed.y > Swing_Speed_Threshold):
		if !currentSwing == SwingStates.DOWN:
			#print("DOWNSWING")
			hovered.downswing()
			currentSwing = SwingStates.DOWN
	elif (mouse_speed.y < -Swing_Speed_Threshold):
		if !currentSwing == SwingStates.UP:
			#print("UPSWING")
			hovered.upswing()
			currentSwing = SwingStates.UP
	elif (mouse_speed.x > Swing_Speed_Threshold):
		if !currentSwing == SwingStates.RIGHT:
			#print("RIGHTSWING")
			hovered.rightswing()
			currentSwing = SwingStates.RIGHT
	elif (mouse_speed.x < -Swing_Speed_Threshold):
		if !currentSwing == SwingStates.LEFT:
			hovered.leftswing()
			#print("LEFTSWING")
			currentSwing = SwingStates.LEFT
	else:
		currentSwing = SwingStates.NEUTRAL

func switch_view(view:CameraPivot.VIEW):
	
	match view:
		CameraPivot.VIEW.TOP:
			camera_pivot.switch_to_top_view()
		CameraPivot.VIEW.FRONT:
			camera_pivot.switch_to_front_view()

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

