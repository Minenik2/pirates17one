extends CanvasLayer
const DEFAULT_STATE := {
	"keyToBody": false,
	"bodyInvestigated": false,
	"thornPaperFound": false,
	"bodyDiscoveredTimeKnown": false,
	"NabellaSaidMarchoCanConfirm": false, #
	"dayWithoutFootSteps": false, #
	
	# first time checks
	"AstarothFirstTime": true,
	"MachoriasFirstTime": false,
	"BeletharaFirstTime": false,
	"GrimoryFirstTime": false,
	"NabellaFirstTime": false,
	
	# act2
	"leftAct2": "0",
	"rightAct2": "0",
	# easter egg
	"solvedMurder": false,
	
	#clues
	# Crime scene
	"clueWindowOpen": false,
	"clueMetallicBullets": false,
	"clueBloodKnife": false,
	# body
	"clueBlood": false,
	"clueRigor": false,
	# occult
	# astaroth
	"hearsMarchosiasScreams": false,
	"upperWent": false,
	"victimBorrowed": false,
	"bookConfirm": false,
	# nabella
	"nabellaHearFootsteps": false,
	# marchosias
	"lostGun": false,
	"upperFloor": false,
	"goodSleep": false,
	# grimory
	"clueGun": false
}

@onready var state = DEFAULT_STATE.duplicate()

signal dialogue_ended
signal cutscene_start

#func _ready() -> void:
	
	
func start_dialogue(dialogue_json: JSON):
	$DialogueBox.is_dialogue_done = false
	($EzDialogue as EzDialogue).start_dialogue(dialogue_json, state)

func _on_ez_dialogue_dialogue_generated(response: DialogueResponse) -> void:
	SfXplayer.playDialogueClick()
	$DialogueBox.clear_dialogue_box()
	$DialogueBox.add_text(response.text)
	if response.choices.is_empty():
		$DialogueBox.add_choice("...")
	else:
		for choice in response.choices:
			$DialogueBox.add_choice(choice)


func _on_ez_dialogue_custom_signal_received(value: Variant) -> void:
	var params = value.split(",")
	if params[0] == "set":
		var variable_name = params[1]
		var variable_value = params[2]
		state[variable_name] = variable_value
		Database.updateClue(variable_name)
	elif params[0] == "tp":
		await get_tree().create_timer(0.1).timeout
		if params[1] == "act3":
			get_tree().change_scene_to_file("res://scenes/bad_end_all.tscn")
		elif params[1] == "mainMenu":
			Database.reset()
			reset_state()
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/act2/act2.tscn")
	elif params[0] == "cut":
		cutscene_start.emit()


func _on_ez_dialogue_end_of_dialogue_reached() -> void:
	$DialogueBox.is_dialogue_done = true
	dialogue_ended.emit()
	
func reset_state():
	state = DEFAULT_STATE.duplicate()
