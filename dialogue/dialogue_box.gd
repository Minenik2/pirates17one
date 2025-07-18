extends CanvasLayer

const CHAR_READ_RATE = 0.02

@onready var choice_button_scn = preload("res://dialogue/ChoiceButton.tscn")

var tween
var choice_buttons: Array[Button] = []
var is_dialogue_done = false
@onready var textBox = $VBoxContainer/TextboxContainer/MarginContainer/HBoxContainer/text
@onready var choiceContainer = $VBoxContainer/MarginContainer/choiceContainer

enum State {
	READING,
	FINISHED
}

var current_state = State.READING

func clear_dialogue_box():
	textBox.text = ""
	for choice in choice_buttons:
		choiceContainer.remove_child(choice)
	choice_buttons = []

func add_text(text: String):
	current_state = State.READING
	$VBoxContainer/TextboxContainer/MarginContainer/HBoxContainer/EndSymbol.text = ""
	textBox.text = text
	textBox.visible_characters = 0

	tween = create_tween()
	tween.tween_property(textBox, "visible_characters", text.length(), text.length() * CHAR_READ_RATE)
	tween.tween_callback(Callable(self, "_on_text_finished"))

func _on_text_finished():
	$VBoxContainer/TextboxContainer/MarginContainer/HBoxContainer/EndSymbol.text = "v"  # Show symbol when text is fully revealed
	current_state = State.FINISHED

func add_choice(choice_text: String):
	var button_obj: ChoiceButton = choice_button_scn.instantiate()
	button_obj.choice_index = choice_buttons.size()
	choice_buttons.push_back(button_obj)
	button_obj.text = choice_text
	button_obj.choice_selected.connect(_on_choice_selected)
	if (choice_text == "..."):
		button_obj.hide()
	choiceContainer.add_child(button_obj)
	

func _on_choice_selected(choice_index: int):
	if !is_dialogue_done:
		($"../EzDialogue" as EzDialogue).next(choice_index)
	else:
		clear_dialogue_box()

func _unhandled_input(_event: InputEvent) -> void:
	# Only advance if no choices are visible
	if current_state == State.READING and Input.is_action_just_pressed("interact"):
		textBox.visible_characters = -1
		tween.stop()
		$VBoxContainer/TextboxContainer/MarginContainer/HBoxContainer/EndSymbol.text = "v"
		current_state = State.FINISHED
	elif choice_buttons.size() == 1 and choice_buttons[0].text.strip_edges() == "..." and Input.is_action_just_pressed("interact") and current_state == State.FINISHED:
		($"../EzDialogue" as EzDialogue).next(-1)
