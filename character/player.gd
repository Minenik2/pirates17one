extends CharacterBody2D

@export var move_speed: float = 150
@export var starting_direction: Vector2 = Vector2(0, 1)

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D  # Make sure your sprite node is named 'Sprite2D'

var interact_key = "interact" # The key for interaction, usually set to "E" or "Enter"
var interaction_radius = 10
var is_interacting = false
var can_interact = true
var animateCutscene = false

var step_timer := 0.0
var step_interval := 0.4  # Time between step sounds, adjust as needed

func _ready():
	DialogueDisplay.dialogue_ended.connect(_on_dialogue_display_dialogue_ended)
	update_animation(Vector2.ZERO)  # Default to idle

func _physics_process(delta):
	step_timer -= delta
	
	if !is_interacting:
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()

		velocity = input_direction * move_speed
		move_and_slide()

		update_animation(input_direction)
	elif !animateCutscene:
		animation_player.pause()

func _unhandled_input(event):
	if event.is_action_pressed(interact_key) and can_interact and !is_interacting and (!TabMenu.visible or TabMenu.is_tip_showing()):
		interact()
	

func update_animation(move_input: Vector2):
	if move_input == Vector2.ZERO:
		animation_player.pause()
		return
	
	if step_timer <= 0.0:
		SfXplayer.play()
		step_timer = step_interval

	if abs(move_input.x) > abs(move_input.y):
		# Horizontal movement
		sprite.flip_h = move_input.x < 0
		play_animation("walk_right")  # Reuse walk_right for both directions
	else:
		# Vertical movement
		sprite.flip_h = false  # No flip for up/down
		if move_input.y > 0:
			play_animation("walk_down")
		else:
			play_animation("walk_up")

func play_animation(name: String):
	if animation_player.current_animation != name or !animation_player.is_playing():
		animation_player.play(name)

func interact():
	var space_state = get_world_2d().direct_space_state
	var query_shape = CircleShape2D.new()
	query_shape.radius = interaction_radius
	var query_params = PhysicsShapeQueryParameters2D.new()
	query_params.set_shape(query_shape)
	query_params.set_transform(global_transform.translated(Vector2(0, 20)))
	query_params.set_collision_mask(1)
	var result = space_state.intersect_shape(query_params)
	
	for collider in result:
		if collider.collider.has_method("on_interact"):
			collider.collider.on_interact()
			break # Stop after the first interaction


func _on_dialogue_display_dialogue_ended() -> void:
	DialogueDisplay.hide()
	is_interacting = false
	can_interact = false
	await get_tree().create_timer(0.2).timeout
	can_interact = true

func walk_for_seconds(direction, duration):
	var time_elapsed = 0.0
	animateCutscene = true

	while time_elapsed < duration:
		var delta = await get_tree().create_timer(0.01).timeout
		velocity = direction * move_speed
		move_and_slide()
		update_animation(direction)
		time_elapsed += 0.01

	velocity = Vector2.ZERO
	move_and_slide()
	animateCutscene = false
