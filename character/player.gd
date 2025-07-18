extends CharacterBody2D

@export var move_speed: float = 150
@export var starting_direction: Vector2 = Vector2(0, 1)

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D  # Make sure your sprite node is named 'Sprite2D'

func _ready():
	update_animation(Vector2.ZERO)  # Default to idle

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()

	velocity = input_direction * move_speed
	move_and_slide()

	update_animation(input_direction)

func update_animation(move_input: Vector2):
	if move_input == Vector2.ZERO:
		animation_player.stop()
		return

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
