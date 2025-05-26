extends Node

@export var current_player: player

@onready var sprite: AnimatedSprite2D = %Sprite

var current_direction: Vector2
var last_direction: Vector2

var current_state: States

var can_move: bool = true

enum States 
{
	Idle,
	Walk
}

func _ready() -> void:
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
	if (_is_moving()):
		current_state = States.Walk

func _walk_state() -> void:
	if (!_is_moving() || !can_move):
		AudioManager.walk_sfx.stop()
		current_state = States.Idle
		return
	AudioManager.walk_sfx.play()
	_move()
	_walk_animation()
#endregion

#region Animations

func _idle_animation() -> void:
	match last_direction:
		Vector2.UP:
			sprite.play("idle_up")
		Vector2.DOWN:
			sprite.play("idle_down")
		Vector2.LEFT:
			sprite.play("idle_left")
		Vector2.RIGHT:
			sprite.play("idle_right")
		_:
			sprite.play("idle_down")

func _walk_animation() -> void:
	match current_direction:
		Vector2.UP:
			sprite.play("walk_up")
		Vector2.DOWN:
			sprite.play("walk_down")
		Vector2.LEFT:
			sprite.play("walk_left")
		Vector2.RIGHT:
			sprite.play("walk_right")
	last_direction = current_direction

#endregion

#region Movement

func _move() -> void:
	current_player.velocity = current_direction * current_player.movement_speed
	current_player.move_and_slide()

#endregion
