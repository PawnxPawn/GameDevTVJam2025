extends Node

@export var current_player: player

@onready var sprite: AnimatedSprite2D = %Sprite

var current_direction: Vector2
var last_direction: Vector2
var push_direction: Vector2 = Vector2.ZERO

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
	push_direction = Vector2.ZERO
	if (_is_moving() && GameManager.can_move && !GameManager.is_zoomed):
		current_state = States.Walk

func _walk_state() -> void:
	_walk_animation()
	if (!_is_moving() || !GameManager.can_move || GameManager.is_zoomed):
		AudioManager.walk_sfx.stop()
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
	current_player.move_and_slide()

#endregion
