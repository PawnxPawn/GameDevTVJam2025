extends CharacterBody2D
class_name player

@export var movement_speed: float = 100
@export var push_strength: float = 300

var block_is_child: bool = false

func _physics_process(_delta: float) -> void:
	check_collision()

func check_collision() -> void:
	var collision: KinematicCollision2D = get_last_slide_collision()

	if (collision):
		var block = collision.get_collider()
		if (block.is_in_group("block")):
			move_block(block, collision)

func move_block(block: Object, collision: KinematicCollision2D) -> void:
	if (Input.is_action_just_pressed("push_pull") && GameManager.current_player_size >= block.size && !block_is_child):
		block_is_child = true
		block.reparent(self)
		block.set_deferred("freeze", true)
		movement_speed /= 2
	elif (Input.is_action_just_pressed("push_pull") && block_is_child):
		block_is_child = false
		block.reparent(get_parent().get_parent())				
		block.set_deferred("freeze", false)
		block.linear_velocity = Vector2.ZERO
		movement_speed *= 2
	else:
		push_pushable(block, collision)


func push_pushable(pushable: RigidBody2D, collision: KinematicCollision2D):
	pushable.apply_central_force(-collision.get_normal() * push_strength)
