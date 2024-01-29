extends ColorRect

var speed : float = 4.0

var current_opacity : float = 2.0
var target_opacity : float = 0.1

var current_closure : float = 1.0
var target_closure : float = 30.0

func _onready():
	current_opacity = 2.0
	current_closure = 1.0

func transition_close(set_speed):
	speed = set_speed
	target_opacity = 2.0
	target_closure = 1.0

func transition_open(set_speed):
	speed = set_speed
	target_opacity = 0.1
	target_closure = 30.0
	
func _process(delta):
	
	current_opacity = lerp(current_opacity, target_opacity, speed * delta)
	current_closure = lerp(current_closure, target_closure, speed * delta)
	
	
#	print(current_opacity, " - ", current_closure)
	(material as ShaderMaterial).set_shader_parameter("vignette_opacity", current_opacity)
	(material as ShaderMaterial).set_shader_parameter("closure", current_closure)
	

