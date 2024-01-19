extends Grabable
class_name Pot

var heated := false
var cook_progress: float


func _physics_process(delta):
	progress_cooking(delta)

var current_content = {
	"WATER" : false,
	"BOILING_BUBBLES": false,
	"NOODLES" : false,
	"COOKED_NOODLES" : false
}
@onready var content_refecences = {
	"WATER" : 			{"object": $Contents/POT_water, "cook_time": 100, "result" : "BOLING_BUBBLES"},
	"BOILING_BUBBLES": 	{"object": $Contents/POT_water,},
	"NOODLES" : 		{"object": $Contents/POT_water, "cook_time": 100, "result" : "COOKED_NOODLES"},
	"COOKED_NOODLES" : 	{"object": $Contents/POT_water,},
}

func add_content(pour : FoodDictionary.POURABLE_TYPE):
	for content_key in current_content:
		if content_key == FoodDictionary.POURABLE_TYPE.keys()[pour]:
			#print(content_key, " - ", FoodDictionary.POURABLE_TYPE.keys()[pour])
			if current_content[content_key]:
				return false ## If already contains this, return false so pouring animation does not play
			current_content[content_key] = true
			content_refecences[content_key]["object"].visible = true
			return true

func progress_cooking(delta):
	if heated:
		cook_progress += delta
