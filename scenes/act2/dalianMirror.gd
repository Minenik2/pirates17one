extends StaticBody2D

func _ready() -> void:
	DialogueDisplay.cutscene_start.connect(_on_cutscene_start)
	
func _on_cutscene_start():
	$".".show()
