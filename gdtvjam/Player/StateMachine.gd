extends Node

@export var current_player: player
@export var minimum_pitch_normal: float = 0.8
@export var maximum_pitch_normal: float = 1.2
@export var minimum_pitch_small: float = 3.8
@export var maximum_pitch_small: float = 4.2
@export var footstep_delay: float = 0.45

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var footstep_sfx: AudioStreamPlayer2D = $'../FootstepCave'
@onready var footstep_dealy_timer: Timer = $'../FootstepDealyTimer'

var current_direction: Vector2
var last_direction: Vector2
var current_position: Vector2
var old_position: Vector2

var current_state: States

enum States 
{
	Idle,
	Walk
}

func _ready() -> void:
	if _is_moving():
		current_state = States.Walk
		return
	current_state = States.Idle
	

func _process(_delta: float) -> void:
	match current_state:
		States.Idle:
			_idle_state()
		States.Walk:
			_walk_state()



#region States
func _is_moving() -> bool:
	current_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return current_direction != Vector2.ZERO

func _idle_state() -> void:
	_idle_animation()
	if (_is_moving() && GameManager.can_move && !GameManager.is_zoomed):
		current_state = States.Walk

func _walk_state() -> void:
	_walk_animation()
	if (!_is_moving() || !GameManager.can_move || GameManager.is_zoomed):
		current_state = States.Idle
		return

	_move()
#endregion

#region Animations

func _idle_animation() -> void:
	if last_direction.y < 0:
		sprite.play("idle_up")
	elif last_direction.y > 0:
		sprite.play("idle_down")
	elif last_direction.x < 0:
		sprite.play("idle_left")
	elif last_direction.x > 0:
		sprite.play("idle_right")
	else:
		sprite.play("idle_down")

func _walk_animation() -> void:

	last_direction = current_direction

	if current_direction.y < 0:
		sprite.play("walk_up")
	elif current_direction.y > 0:
		sprite.play("walk_down")
	elif current_direction.x < 0:
		sprite.play("walk_left")
	elif current_direction.x > 0:
		sprite.play("walk_right")

#endregion

#region Movement

func _move() -> void:
	current_player.velocity = current_direction * current_player.movement_speed
	if player_has_moved():
		_play_footsteps()
	current_player.move_and_slide()
#endregion

#region Sounds
func _play_footsteps() -> void:	
	if footstep_dealy_timer.is_stopped():
		if GameManager.current_player_size == GameManager.character_size.NORMAL:
			footstep_sfx.pitch_scale = randf_range(minimum_pitch_normal, maximum_pitch_normal)
		else:
			footstep_sfx.pitch_scale = randf_range(minimum_pitch_small, maximum_pitch_small)

		footstep_dealy_timer.start(footstep_delay)
		footstep_sfx.play()
#endregion

#region HelperFunctions
func player_has_moved() -> bool:
	current_position = current_player.global_position
	if current_position != old_position:
		old_position = current_position
		return true
	return false
#endregion
