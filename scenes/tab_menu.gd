extends CanvasLayer

@onready var suspects: MarginContainer = $MarginContainer/VBoxContainer/Suspects
@onready var alibis: MarginContainer = $MarginContainer/VBoxContainer/Alibis
@onready var victim: MarginContainer = $MarginContainer/VBoxContainer/Victim
@onready var info: MarginContainer = $MarginContainer/VBoxContainer/Info

@onready var textureSprite: TextureRect = $MarginContainer/VBoxContainer/Suspects/HBoxContainer/VBoxContainer2/TextureRect
@onready var profile: RichTextLabel = $MarginContainer/VBoxContainer/Suspects/HBoxContainer/VBoxContainer2/MarginContainer/profile

@onready var scene_list: ItemList = $"MarginContainer/VBoxContainer/Victim/HBoxContainer/TabContainer/Crime Scene/MarginContainer/VBoxContainer/sceneList"
@onready var body_list: ItemList = $"MarginContainer/VBoxContainer/Victim/HBoxContainer/TabContainer/Dead Body/MarginContainer/VBoxContainer/bodyList"
@onready var occult_list: ItemList = $"MarginContainer/VBoxContainer/Victim/HBoxContainer/TabContainer/???/MarginContainer/VBoxContainer/occultList"

@onready var infoText: RichTextLabel = $MarginContainer/VBoxContainer/Victim/HBoxContainer/PanelContainer4/MarginContainer/VBoxContainer/RichTextLabel


func _ready():
	updateClues()
	
func updateClues():
	for clue in Database.clueScene:
		if clue["discovered"]:
			scene_list.add_item(clue["title"])
	for clue in Database.clueBody:
		if clue["discovered"]:
			body_list.add_item(clue["title"])
	for clue in Database.clueOccult:
		if clue["discovered"]:
			occult_list.add_item(clue["title"])

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("tab_menu") and not is_in_main_menu():
		SfXplayer.playDialogueClick()
		updateClues()
		
		if $".".visible and !$tabTip.visible:
			$".".hide()
		elif $tabTip.visible:
			$TextureRect.show()
			$MarginContainer.show()
			$tabTip.hide()
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


func _on_grimory_pressed() -> void:
	SfXplayer.playDialogueClick()
	textureSprite.texture = load("res://art/grimory.png")
	profile.text = "Abdi has not yet added a description to this character. Maybe one day when the clock strikes twelve he will lift his pen and inspiration to start commencing the bibliographical narrative."
	

func _on_astaroth_pressed() -> void:
	SfXplayer.playDialogueClick()
	textureSprite.texture = load("res://art/scholar.png")
	profile.text = "Mohammed has not yet added a description to this character.
	 Maybe one day when the clock strikes twelve he will lift his pen and inspiration to start commencing the bibliographical narrative."

func _on_marchosias_pressed() -> void:
	SfXplayer.playDialogueClick()
	textureSprite.texture = load("res://art/grimory.png")
	profile.text = "Journal Entry - Subject: Marchosias
Location: Apartment, Upper floor
Date: July 20th
Filed by: Dalian

Marchosias. No relatives I could trace. Just a name whispered in the halls, the madman on the third floor.

He says he fought in the georgist war, not that most people remember it. A movement built on land reform and righteous ideals, twisted into something bloody by the time it reached the trenches. He was young then. Idealistic. Said he fought 'for the earth beneath all feet to be shared equally.' Now he mutters those same words through rotted teeth, rocking in a wooden chair that creaks louder than his bones.

He is a man who saw his brothers die in muddy fields for something he still believes in. That's rare. He must have carried the weight of their deaths. He also claims no one listens to George's teachings because 'They've never truley heard them' Says the world is deaf. Says we're all parasites sucking on the landowners lies. But he doesn't hate people, he pities them. That's what hassles me."
	
func _on_belethara_pressed() -> void:
	SfXplayer.playDialogueClick()
	textureSprite.texture = load("res://art/grimory.png")
	profile.text = "Abdi has not yet added a description to this character. Maybe one day when the clock strikes twelve he will lift his pen and inspiration to start commencing the bibliographical narrative."

func _on_nabella_pressed() -> void:
	SfXplayer.playDialogueClick()
	textureSprite.texture = load("res://art/grimory.png")
	profile.text = "Abdi has not yet added a description to this character. Maybe one day when the clock strikes twelve he will lift his pen and inspiration to start commencing the bibliographical narrative."

func _on_tab_container_tab_changed(tab: int) -> void:
	SfXplayer.playDialogueClick()
	match tab:
		0:	
			scene_list.deselect_all()
		1:
			body_list.deselect_all()
		2:
			occult_list.deselect_all()

func _on_occult_list_item_selected(index: int) -> void:
	var clue = Database.clueOccult[index]
	infoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_body_list_item_selected(index: int) -> void:
	var clue = Database.clueBody[index]
	infoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_scene_list_item_selected(index: int) -> void:
	var clue = Database.clueScene[index]
	infoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_alibi_tab_container_tab_changed(tab: int) -> void:
	SfXplayer.playDialogueClick()
