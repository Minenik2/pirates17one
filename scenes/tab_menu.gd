extends CanvasLayer

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("tab_menu") and not is_in_main_menu():
		SfXplayer.playDialogueClick()
		if $".".visible:
			$".".hide()
		else:
			$".".show()

func is_in_main_menu() -> bool:
	var current_scene = get_tree().current_scene
	return current_scene.scene_file_path == "res://scenes/main_menu.tscn"
