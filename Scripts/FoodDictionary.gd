extends Node
class_name FoodDictionary

enum POURABLE_TYPE { WATER, RICE, SOY}

enum IngredientID{	tomato, carrot, onion, garlic, mushroom, potato, green_leaves, meat,
					chopped_tomato, chopped_carrot, chopped_onion, chopped_garlic, chopped_mushroom, chopped_potato,
					
				}

var Starters = { 
	"Vegetable Salad": [IngredientID.chopped_tomato , IngredientID.chopped_carrot, IngredientID.chopped_onion, IngredientID.green_leaves],
	"name" : "Mushroom Plate", "ingredients": [],
	}
