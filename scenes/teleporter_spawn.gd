extends Area2D

@export var code: String
@export var player: CharacterBody2D

func _ready():
	if Database.teleportCode == code:
		# Wait a frame to ensure player node is ready
		await get_tree().process_frame
		
		player.global_position = global_position
