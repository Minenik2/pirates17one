extends Area2D

@export var code: String
@export var player: CharacterBody2D

func _ready():
	# Wait a frame to ensure player node is ready
	await get_tree().process_frame
	
	player.global_position = global_position
