extends Area2D

@export_file("*.tscn") var target_scene: String
@export var code: String

func _on_body_entered(body):
	if body.is_in_group("player"):
		SfXplayer.playStairs2()
		Database.teleportCode = code
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		SfXplayer.playStairs()
		get_tree().change_scene_to_file(target_scene)
