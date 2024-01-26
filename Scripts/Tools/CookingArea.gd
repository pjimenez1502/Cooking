extends Area3D
class_name CookingArea

var available := true
enum Area_Name { STOVE_R, STOVE_L, CENTERBOARD, CUTTINGBOARD , KNIFEREST, BOWL, PAN, POT , DELIVERY_1, DELIVERY_2, DELIVERY_3, DELIVERY_4,}
@export var area_name : Area_Name
	
func set_available(value : bool):
	available = value

func check_area_compatible(grabbed_compatible_areas: Array):
	if !available:
		return false
	for grabbed_area in grabbed_compatible_areas:
		#print(grabbed_area, " - ", Area_Name.keys()[area_name])
		if grabbed_area == Area_Name.keys()[area_name]:
			#print(grabbed_area)
			return true
	return false
