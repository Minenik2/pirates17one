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
# alibis
@onready var belethara_list: ItemList = $MarginContainer/VBoxContainer/Alibis/HBoxContainer/TabContainer/Belethara/MarginContainer/VBoxContainer/beletharaList
@onready var nabella_list: ItemList = $MarginContainer/VBoxContainer/Alibis/HBoxContainer/TabContainer/Nabella/MarginContainer/VBoxContainer/nabellaList
@onready var marchosias_list: ItemList = $MarginContainer/VBoxContainer/Alibis/HBoxContainer/TabContainer/Marchosias/MarginContainer/VBoxContainer/marchosiasList
@onready var astaroth_list: ItemList = $MarginContainer/VBoxContainer/Alibis/HBoxContainer/TabContainer/Astaroth/MarginContainer/VBoxContainer/astarothList
@onready var grimory_list: ItemList = $MarginContainer/VBoxContainer/Alibis/HBoxContainer/TabContainer/Grimory/MarginContainer/VBoxContainer/grimoryList

@onready var alibiInfoText: RichTextLabel = $MarginContainer/VBoxContainer/Alibis/HBoxContainer/PanelContainer4/MarginContainer/VBoxContainer/RichTextLabel


func _ready():
	updateClues()
	
func updateClues():
	scene_list.clear()
	body_list.clear()
	occult_list.clear()
	
	# alibi
	nabella_list.clear()
	marchosias_list.clear()
	belethara_list.clear()
	grimory_list.clear()
	astaroth_list.clear()
	
	addClues(scene_list, Database.clueScene)
	addClues(body_list, Database.clueBody)
	addClues(occult_list, Database.clueOccult)
	
	# alibi
	addClues(nabella_list, Database.clueNabella)
	addClues(marchosias_list, Database.clueMarchosias)
	addClues(belethara_list, Database.clueBelethara)
	addClues(grimory_list, Database.clueGrimory)
	addClues(astaroth_list, Database.clueAstaroth)

func addClues(list, clueList):
	for clue in clueList:
		if clue["discovered"]:
			var index = list.add_item(clue["title"])
			list.set_item_metadata(index, clue["title"])

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

func is_tip_showing() -> bool:
	return $tabTip.visible

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
	profile.text = "Journal Entry - Subject: Grimory
Location: Apartment, Lower floor
Date: July 20th
Filed by: Dalian

Grimory. She is a seamstress proficient in sewing. Hired by Belethera to make the perfect dress for her majesty."
	

func _on_astaroth_pressed() -> void:
	SfXplayer.playDialogueClick()
	textureSprite.texture = load("res://art/scholar.png")
	profile.text = "Journal Entry - Subject: Astaroth
Location: Apartment, Upper floor
Date: July 20th
Filed by: Dalian

Astaroth. He seems to be hungry, hungry for knowledge. He hoards countless amounts of books and texts, foolishly trying to research some kind of ancient language."

func _on_marchosias_pressed() -> void:
	SfXplayer.playDialogueClick()
	textureSprite.texture = load("res://art/marchosisas.png")
	profile.text = "Journal Entry - Subject: Marchosisas
Location: Apartment, Upper floor
Date: July 20th
Filed by: Dalian

Marchosisas. Rather ideologistic person, with an ideology that lives with him to this day. He said he proudly believes in georgism and mutters those words through his rotted teeth, rocking in a wooden chair that creaks louder than his bones."
	
func _on_belethara_pressed() -> void:
	SfXplayer.playDialogueClick()
	textureSprite.texture = load("res://art/beleth.png")
	profile.text = "Journal Entry - Subject: Belethara
Location: Apartment, Middle floor
Date: July 20th
Filed by: Dalian

Belethara. The owner of this crooked building, I don't think any sane soul would want to live in a place like this - let alone be the owner of it. Her song has long played and she uses the last moments of her life to prickly take care of a useless building"

func _on_nabella_pressed() -> void:
	SfXplayer.playDialogueClick()
	textureSprite.texture = load("res://art/nabella.png")
	profile.text = "Journal Entry - Subject: Nabella
Location: Apartment, Middle floor
Date: July 20th
Filed by: Dalian

Nabella. The timid cleaning lady, she comes from a poor family and doesn't have many ambitions. Can you imagine that - living life without any goals - must be a pity of a woman. "

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
	var clue = findSameTitle(Database.clueOccult, occult_list.get_item_metadata(index))
	infoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_body_list_item_selected(index: int) -> void:
	var clue = findSameTitle(Database.clueBody, body_list.get_item_metadata(index))
	infoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_scene_list_item_selected(index: int) -> void:
	var clue = findSameTitle(Database.clueScene, scene_list.get_item_metadata(index))
	infoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_alibi_tab_container_tab_changed(tab: int) -> void:
	SfXplayer.playDialogueClick()
	match tab:
		0:	
			belethara_list.deselect_all()
		1:
			nabella_list.deselect_all()
		2:
			marchosias_list.deselect_all()
		3:
			astaroth_list.deselect_all()
		4:
			grimory_list.deselect_all()

# alibis buttons
func _on_grimory_list_item_selected(index: int) -> void:
	var clue = findSameTitle(Database.clueGrimory, grimory_list.get_item_metadata(index))
	alibiInfoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_astaroth_list_item_selected(index: int) -> void:
	var clue = findSameTitle(Database.clueAstaroth, astaroth_list.get_item_metadata(index))
	alibiInfoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_marchosias_list_item_selected(index: int) -> void:
	var clue = findSameTitle(Database.clueMarchosias, marchosias_list.get_item_metadata(index))
	alibiInfoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_nabella_list_item_selected(index: int) -> void:
	var clue = findSameTitle(Database.clueNabella, nabella_list.get_item_metadata(index))
	alibiInfoText.text = clue["description"]
	SfXplayer.playDialogueClick()


func _on_belethara_list_item_selected(index: int) -> void:
	var clue = findSameTitle(Database.clueBelethara, belethara_list.get_item_metadata(index))
	alibiInfoText.text = clue["description"]
	SfXplayer.playDialogueClick()

func findSameTitle(clueList, title):
	for clue in clueList:
		if clue["title"] == title:
			return clue
