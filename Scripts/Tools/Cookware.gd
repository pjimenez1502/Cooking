extends Pourable
class_name Cookware

var heated := false
@export var self_area_collider : CollisionShape3D

func _physics_process(delta):
	super._physics_process(delta)
	progress_cooking(delta)

var current_content = {
	"chopped_onion": {"active": false, "cook_time": 0 },
	"chopped_carrot": {"active": false, "cook_time": 0 },
	"chopped_tomato": {"active": false, "cook_time": 0 },
	"chopped_mushroom": {"active": false, "cook_time": 0 },
	"chopped_garlic": {"active": false, "cook_time": 0 },
	#"green_leaves": {"active": false, "cook_time": 0},
	"sauteed_noodles": {"active": false, "cook_time": 0},
	
	"sauteed_onion": {"active": false, "cook_time": 0 },
	"sauteed_carrot": {"active": false, "cook_time": 0 },
	"sauteed_tomato": {"active": false, "cook_time": 0 },
	"sauteed_mushroom": {"active": false, "cook_time": 0 },
	"sauteed_garlic": {"active": false, "cook_time": 0 },
	#"sauteed_green_leaves": {"active": false, "cook_time": 0},
	"fried_noodles": {"active": false, "cook_time": 0},
	
	"burned_onion": {"active": false, "cook_time": 0 },
	"burned_carrot": {"active": false, "cook_time": 0 },
	"burned_tomato": {"active": false, "cook_time": 0 },
	"burned_mushroom": {"active": false, "cook_time": 0 },
	"burned_garlic": {"active": false, "cook_time": 0 },
	#"burned_green_leaves": {"active": false, "cook_time": 0},
	"burned_noodles": {"active": false, "cook_time": 0},
	
	"SOY": {"active": false},
}
var content_refecences = {}

func grab():
	super.grab()
	self_area_collider.disabled = true

func release():
	super.release()
	self_area_collider.disabled = false

#func _on_ingredient_capture_body_entered(body):
func add_ingredient(body):
	if !body is Ingredient:
		return
	var body_content_key = FoodDictionary.IngredientID.keys()[body.id]

	for content_key in content_refecences:
		if content_key == body_content_key:
			if current_content[content_key]["active"]:
				return
			set_ingredient_active(content_key, true)
			body.queue_free()

func progress_cooking(delta):
	
	if !heated:
		return
	for content_key in current_content:
		if !current_content[content_key]["active"]:
			continue
		if !content_refecences[content_key].has("cook_time"):
			continue
			
		current_content[content_key]["cook_time"] += delta
		if current_content[content_key]["cook_time"] >= content_refecences[content_key]["cook_time"]:
			set_ingredient_active(content_key, false)
			
			var cookresult = content_refecences[content_key]["result"]
			set_ingredient_active(cookresult, true)

func add_pourable(_pour : FoodDictionary.POURABLE_TYPE):
	#print(FoodDictionary.POURABLE_TYPE.keys()[pour])
	for content_key in current_content:
		if content_key == FoodDictionary.POURABLE_TYPE.keys()[_pour]:
			if current_content[content_key]["active"]:
				return false ## If already contains this, return false so pouring animation does not play
			set_ingredient_active(content_key, true)
			return true

func pour():
	for body in pourable_area.get_overlapping_bodies():
		if body is Plate:
			var ingredient_list : Array
			for content_key in current_content:
				if current_content[content_key]["active"]:
					ingredient_list.push_back(content_key)
					set_ingredient_active(content_key, false)
			body.plate_ingredients(ingredient_list)



func set_ingredient_active(content_key: String, active: bool):
		current_content[content_key]["active"] = active
		content_refecences[content_key]["object"].visible = active
