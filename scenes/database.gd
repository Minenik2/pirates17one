extends Node

var teleportCode = ""
var triggered_flags := {} # triggered events saving across scenes

# to add clue interaction with dialogue state do for example DialogueDisplay.state["clueBloodType"]
var clueScene = [
	{"title": "Open Window", "description": "The window was open in the victims room.", "discovered": true, "tag": ""},
	{"title": "Master Key", "description": "The key that Belethara gave you - can open any door - but she specifically told you to use it on the victims room.", "discovered": false, "tag": "keyToBody"}
]
var clueBody = [
	{"title": "Blood Type", "description": "Victims blood type is B-.", "discovered": true, "tag": ""},
	{"title": "Time of Death", "description": "Victim must have died between 7-9 PM yesterday.", "discovered": true, "tag": ""},
	{"title": "Time of Discovery", "description": "Belethera claims she discovered the body first at 8:12 AM Today.", "discovered": false, "tag": "bodyDiscoveredTimeKnown"}
]
var clueOccult = [
	{"title": "Thorn Paper", "description": "Found in the victims pocket, it shows a symbol of an bleeding eye covered in ink.", "discovered": true, "tag": ""}
]

# alibies
var clueBelethara = [
	{"title": "Alibi - Today", "description": "belethara", "discovered": true, "tag": ""},
	{"title": "I haven't touched anything down there.", "description": "Belethara states that she hasn't touched or moved anything in the room.", "discovered": false, "tag": "keyToBody"}
]
var clueNabella = [
	{"title": "Alibi", "description": "nabella", "discovered": true, "tag": ""}
]
var clueMarchosias = [
	{"title": "Alibi", "description": "marchosias", "discovered": true, "tag": ""}
]
var clueAstaroth = [
	{"title": "Alibi", "description": "astaroth", "discovered": true, "tag": ""}
]
var clueGrimory = [
	{"title": "Alibi", "description": "grimory", "discovered": true, "tag": ""}
]

func updateClue(tag):
	var all_clue_lists = [
		clueScene,
		clueBody,
		clueOccult,
		clueBelethara,
		clueNabella,
		clueMarchosias,
		clueAstaroth,
		clueGrimory
	]

	for clue_list in all_clue_lists:
		_set_clue_discovered(tag, clue_list)

func _set_clue_discovered(tag, clue_list):
	for clue in clue_list:
		if clue["tag"] == tag:
			clue["discovered"] = true
			print("added a new clue called: ", clue["title"])
			break
