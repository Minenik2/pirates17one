extends Area2D

@export var dialogue_resource: JSON

var triggered = false


func _on_body_entered(body: Node2D) -> void:
	if !triggered and body.is_in_group("player"):
		$"../DialogueDisplay".show()
		$"../DialogueDisplay".start_dialogue(dialogue_resource)
		$"../CharacterBody2D".is_interacting = true
		triggered = true
