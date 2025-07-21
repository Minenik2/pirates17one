extends StaticBody2D

@export var dialogue_resource: JSON
@export var player: CharacterBody2D

@export_group("Teleporter Settings")
@export var teleporter: bool = false

@export_subgroup("If Teleporter Is Enabled")
@export var code: String
@export var check: String = "default"
@export_file("*.tscn") var target_scene: String


func _ready():
	# Fallback to default if player not manually assigned in inspector
	if player == null:
		player = get_node("../player")

func on_interact():
	if teleporter and DialogueDisplay.state[check]:
		SfXplayer.playStairs()
		Database.teleportCode = code
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file(target_scene)
	else:
		DialogueDisplay.show()
		DialogueDisplay.start_dialogue(dialogue_resource)
		player.is_interacting = true
