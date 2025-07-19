extends StaticBody2D

@export var dialogue_resource: JSON

func on_interact():
	$"../DialogueDisplay".show()
	$"../DialogueDisplay".start_dialogue(dialogue_resource)
	$"../CharacterBody2D".is_interacting = true
	print("interacting with chair")
