extends CharacterBody2D
class_name player

#region variables
@export var movement_speed: float = 100
@export var push_strength: float = 300

@export var normal_tiles: TileMapLayer

@export var feedback_dialogue: DialogueResource
@export var animation_player: AnimationPlayer

@onready var camera: Camera2D = %Camera

var block_is_child: bool = false
#endregion

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
		push_pushable(block, collision)


func push_pushable(pushable: RigidBody2D, collision: KinematicCollision2D):
	pushable.apply_central_force(-collision.get_normal() * push_strength)
#endregion
#region Tile Map Checker

func _process(_delta: float) -> void:
	if normal_tiles:
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
		
		#Too Big
		if (walkable_small && GameManager.current_player_size == GameManager.character_size.NORMAL):
			DialogueManager.show_example_dialogue_balloon(feedback_dialogue, "TooBig")
			reset_level()
			return
		#Not Walkable Period
		if (!walkable):
			DialogueManager.show_example_dialogue_balloon(feedback_dialogue, "NotWalkable")
			reset_level()
			return
		if (shrink_tile && GameManager.current_player_size == GameManager.character_size.NORMAL):
			DialogueManager.show_example_dialogue_balloon(feedback_dialogue, "Shrink")
			animation_player.play("size_change")
			GameManager.current_player_size = GameManager.character_size.SMALL
			return
		if (grow_tile && GameManager.current_player_size == GameManager.character_size.SMALL):
			DialogueManager.show_example_dialogue_balloon(feedback_dialogue, "Grow")
			animation_player.play("size_change")
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
	get_tree().reload_current_scene()
	print("Should reset")
#endregion
