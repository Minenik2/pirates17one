extends StaticBody2D
func on_interact():
	$"../DialogueDisplay".show()
	$"../DialogueDisplay".start_dialogue(load("res://dialogue/1St meet lady Gremory.json"))
	$"../CharacterBody2D".is_interacting = true
	print("interacting with DOOR")
