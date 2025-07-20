extends CanvasLayer

@onready var suspects: MarginContainer = $MarginContainer/VBoxContainer/Suspects
@onready var alibis: MarginContainer = $MarginContainer/VBoxContainer/Alibis
@onready var victim: MarginContainer = $MarginContainer/VBoxContainer/Victim
@onready var info: MarginContainer = $MarginContainer/VBoxContainer/Info


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


func _on_suspects_pressed() -> void:
	SfXplayer.playDialogueClick()
	alibis.hide()
	victim.hide()
	info.hide()
	suspects.show()
	


func _on_info_pressed() -> void:
	SfXplayer.playDialogueClick()
	suspects.hide()
	alibis.hide()
	victim.hide()
	info.show()
	


func _on_alibis_pressed() -> void:
	SfXplayer.playDialogueClick()
	suspects.hide()
	victim.hide()
	info.hide()
	alibis.show()


func _on_victim_pressed() -> void:
	SfXplayer.playDialogueClick()
	suspects.hide()
	alibis.hide()
	info.hide()
	victim.show()
