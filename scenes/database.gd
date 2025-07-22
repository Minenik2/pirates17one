extends Node

var teleportCode = ""
var triggered_flags := {} # triggered events saving across scenes

# to add clue interaction with dialogue state do for example DialogueDisplay.state["clueBloodType"]
var clueScene = [
	{"title": "Open Window", "description": "the window was open in the victims room.", "discovered": true}
]
var clueBody = [
	{"title": "Blood Type", "description": "Victims blood type is B-.", "discovered": true},
	{"title": "Time of Death", "description": "Victim must have died between 7-9 PM yesterday.", "discovered": true}
]
var clueOccult = [
	{"title": "Thorn Paper", "description": "Found in the victims pocket, it shows a symbol of an bleeding eye covered in ink.", "discovered": true}
]
