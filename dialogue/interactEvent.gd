extends StaticBody2D

@export var dialogue_resource: JSON
@export var player: CharacterBody2D

func _ready():
	# Fallback to default if player not manually assigned in inspector
	if player == null:
		player = get_node("../CharacterBody2D")

func on_interact():
	DialogueDisplay.show()
	DialogueDisplay.start_dialogue(dialogue_resource)
	player.is_interacting = true
