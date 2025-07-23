extends Node

var teleportCode = ""
var triggered_flags := {} # triggered events saving across scenes

# to add clue interaction with dialogue state do for example DialogueDisplay.state["clueBloodType"]
var clueScene = [
	{"title": "Locked Window", "description": "The window was locked in the victims room.", "discovered": true, "tag": ""},
	{"title": "Master Key", "description": "The key that Belethara gave you - can open any door - but she specifically told you to use it on the victims room.", "discovered": false, "tag": "keyToBody"},
	{"title": "Bloody Knife", "description": "A knife was found in Grimorys room with the blood type B-", "discovered": true, "tag": ""},
	{"title": "Metallic Bullets", "description": "Marchosias has metallic bullets inside of his room.", "discovered": true, "tag": ""}
]
var clueBody = [
	{"title": "Blood Type", "description": "Victims blood type is B-.", "discovered": false, "tag": "clueBlood"},
	{"title": "Time of Death", "description": "Judging by the Rigor Mortis. The victim must have died between 7-9 PM yesterday.", "discovered": false, "tag": "clueRigor"},
	{"title": "Time of Discovery", "description": "Belethara claims she discovered the body first at 8:12 AM Today.", "discovered": false, "tag": "bodyDiscoveredTimeKnown"},
	{"title": "Solomon", "description": "According to Belethara, the name of the victim was Solomon, he left his name on his receipt.", "discovered": false, "tag": "clueNameSolomon"},
	{"title": "Fallen Naturally", "description": "There are no signs of dragging the body.", "discovered": false, "tag": "bodyInvestigated"},
	{"title": "Murder Weapon?", "description": "The wounds seems to be formed by a metallic object.", "discovered": false, "tag": "clueBlood"}
]
var clueOccult = [
	{"title": "Thorn Paper", "description": "Found in the victims pocket, it shows a symbol of an bleeding eye covered in ink.", "discovered": false, "tag": "thornPaperFound"}
]

# alibies
var clueBelethara = [
	{"title": "First", "description": "Belethara states that she was the first one to discover the body at 8:12 AM.", "discovered": false, "tag": ""},
	{"title": "I haven't touched anything down there.", "description": "Belethara states that she hasn't touched or moved anything in the room.", "discovered": false, "tag": "keyToBody"},
	{"title": "Nabella was supposed to clean the victims room.", "description": "Belethara states that Nabella was supposed to clean the victims room at 7:30 AM Today, but she did not.\n\nI should confront Nabella about this.", "discovered": false, "tag": "bodyDiscoveredTimeKnown"},
	{"title": "I heard screams.", "description": "Belethara states that she heard shouting yesterday.", "discovered": false, "tag": "bodyDiscoveredTimeKnown"}
]
var clueNabella = [
	{"title": "Extra Cleaning", "description": "Nabella states that she had to clean the upper floor longer than usual due to Marchosias trash piling up.\n\nI should confront Marchosias about this.", "discovered": false, "tag": "NabellaSaidMarchoCanConfirm"},
	{"title": "Middle Cleaning", "description": "Nabella states that today she cleaned the upper floor first, currently is cleaning the middle floor and only after finishing would she start cleaning the lower floor.", "discovered": false, "tag": "NabellaSaidMarchoCanConfirm"},
	{"title": "Upper Footsteps", "description": "Nabella states that she heard footsteps coming from the upper floor yesterday. She believes it was Marchosias but she did not see the person.", "discovered": true, "tag": ""}
]
var clueMarchosias = [
	{"title": "Cleaning Duties", "description": "Marchosias states that Nabella starts cleaning at 7:30, not finishes cleaning at 7:30, and she always start cleaning upper floor first.", "discovered": false, "tag": "dayWithoutFootSteps"},
	{"title": "Hearing Footsteps", "description": "Marchosias states that he hears footsteps outside of his room every day. Except for yesterday.", "discovered": false, "tag": "dayWithoutFootSteps"},
	{"title": "Good Night Sleep", "description": "Marchosias states that he slept very good yesterday.", "discovered": true, "tag": ""},
	{"title": "No Screaming", "description": "Marchosias states that he has never noticed himself screaming.", "discovered": true, "tag": ""},
	{"title": "All Day Up", "description": "Marchosias states that he was on the upper floor yesterday.", "discovered": true, "tag": ""},
	{"title": "Lost Gun", "description": "Marchosias states that he lost his gun.", "discovered": false, "tag": "lostGun"}
]
var clueAstaroth = [
	{"title": "Upper Floor", "description": "Astaroth claims he went to the upper floor yesterday.", "discovered": true, "tag": ""},
	{"title": "Insomnia", "description": "Astaroth claims that he never gets to sleep because Marchosias always screams at night.", "discovered": true, "tag": ""},
	{"title": "Yesterday Was Quiet.", "description": "Astaroth claims that yesterday he had a good night sleep because Marchosias did not scream.", "discovered": true, "tag": ""},
	{"title": "Visited The Seamstress", "description": "Astaroth claims that he borrowed books from Grimory yesterday.", "discovered": true, "tag": ""}
]
var clueGrimory = [
	{"title": "Gun Fire", "description": "Grimory states that she heard a loud gun fire around 8 PM Yesterday", "discovered": false, "tag": "clueGun"},
	{"title": "The only one with the gun", "description": "Grimory states that Marchosias is the only person with a gun.\n\nI should confront Marchosias about this", "discovered": false, "tag": "clueGun"},
	{"title": "Bookworms visit", "description": "Grimory states that Astaroth visited Grimory to borrow a book from her.\n\nI should confront Astaroth about this", "discovered": false, "tag": "clueGun"}
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
