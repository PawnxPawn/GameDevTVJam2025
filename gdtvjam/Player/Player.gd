extends CharacterBody2D
class_name player

@export var movement_speed: float = 100
@export var push_strength: float = 300

@export var normal_tiles: TileMapLayer

@export var current_level: PackedScene
var block_is_child: bool = false

@onready var camera: Camera2D = %Camera

#region Move Block
func _physics_process(_delta: float) -> void:
	check_collision()

func check_collision() -> void:
	var collision: KinematicCollision2D = get_last_slide_collision()

	if (collision):
		var block = collision.get_collider()
		if (block.is_in_group("block")):
			move_block(block, collision)

func move_block(block: Object, collision: KinematicCollision2D) -> void:
	if (Input.is_action_just_pressed("push_pull") && !block_is_child):
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
#endregion
#region Tile Map Checker

func _process(_delta: float) -> void:
	check_normal_tiles()
	if (GameManager.current_player_size == GameManager.character_size.NORMAL):
		set_physics_process(true) #Able to push the damn block
	else:
		set_physics_process(false) #Unable to push the damn block
	
	adjust_player()

func check_normal_tiles() -> void:
	var cell := normal_tiles.local_to_map(position)
	var data: TileData = normal_tiles.get_cell_tile_data(cell)
	if data != null:
		var walkable: bool = data.get_custom_data("walkable")
		var shrink_tile: bool = data.get_custom_data("shrink_tile")
		var grow_tile: bool = data.get_custom_data("grow_tile")
		var walkable_small: bool = data.get_custom_data("walkable_small")
		var normal_size_passable: bool = data.get_custom_data("normal_size_passable")
		
		if (walkable_small && GameManager.current_player_size == GameManager.character_size.NORMAL):
			reset_level()
			return
		if (!walkable):
			reset_level()
			return
		if (!normal_size_passable && GameManager.current_player_size == GameManager.character_size.NORMAL):
			reset_level()
			return
		if (shrink_tile && GameManager.current_player_size == GameManager.character_size.NORMAL):
			GameManager.current_player_size = GameManager.character_size.SMALL
			return
		if (grow_tile && GameManager.current_player_size == GameManager.character_size.SMALL):
			GameManager.current_player_size = GameManager.character_size.NORMAL
			return
		

func adjust_player() -> void:
	if (GameManager.current_player_size == GameManager.character_size.SMALL):
		camera.zoom = Vector2 (10, 10)
		scale = Vector2(0.1, 0.1)
	else:
		camera.zoom = Vector2.ONE
		scale = Vector2.ONE

func reset_level() -> void:
	#get_tree().change_scene_to_packed(current_level)
	print("Should reset")
#endregion