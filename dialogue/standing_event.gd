extends Area2D

@export var dialogue_resource: JSON
@export var trigger_id: String  # Give each area a unique ID

var triggered = false

func _ready():
	if Database.triggered_flags.has(trigger_id):
		triggered = Database.triggered_flags[trigger_id]
	else:
		Database.triggered_flags[trigger_id] = false

func _on_body_entered(body: Node2D) -> void:
	if !triggered and body.is_in_group("player"):
		$"../DialogueDisplay".show()
		$"../DialogueDisplay".start_dialogue(dialogue_resource)
		$"../CharacterBody2D".is_interacting = true
		triggered = true
		Database.triggered_flags[trigger_id] = true
