extends Node
class_name FoodDictionary

enum POURABLE_TYPE { WATER, RICE, SOY}

enum IngredientID {tomato, carrot, onion, garlic, mushroom, potato, green_leaves,
				chopped_tomato, chopped_carrot, chopped_onion, chopped_garlic, chopped_mushroom, chopped_potato,
				soy_sauce,
				raw_noodles, cooked_noodles,
					}

var Starters = { 
	"Vegetable Salad": [IngredientID.chopped_tomato , IngredientID.chopped_carrot, IngredientID.chopped_onion, IngredientID.green_leaves],
	"name" : "Mushroom Plate", "ingredients": [],
	}
