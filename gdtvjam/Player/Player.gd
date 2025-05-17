extends CharacterBody2D
class_name player

@export var movement_speed: float = 100
@export var push_strength: float = 300

func _physics_process(_delta: float) -> void:
	check_collision()

func check_collision() -> void:
	var collision: KinematicCollision2D = get_last_slide_collision()

	if (collision):
		var collider_node = collision.get_collider()
		if (collider_node.is_in_group("block")):
			push_pushable(collider_node, collision)


func push_pushable(pushable: RigidBody2D, collision: KinematicCollision2D):
	pushable.apply_central_force(-collision.get_normal() * push_strength)
