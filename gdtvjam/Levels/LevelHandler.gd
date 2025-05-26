extends Node

@export var north_start: Marker2D
@export var south_start: Marker2D
@export var east_start: Marker2D
@export var west_start: Marker2D
@export var blocks: Array[RigidBody2D]


@export var current_player: CharacterBody2D


func _ready() -> void:
	if not blocks.is_empty():
		for block in blocks:
			if GameManager.block_locations.has(block.block_name):
				block.global_position = GameManager.block_locations[block.block_name]
	
	if (GameManager.level_first_load):
		GameManager.level_first_load = false
		GameManager.player_size_when_entered = GameManager.current_player_size
		if (north_start == null && south_start == null && west_start == null && east_start == null):
			GameManager.entered_direction = GameManager.directions.SOUTH
		determine_position()
	else:
		GameManager.current_player_size = GameManager.player_size_when_entered
		current_player.position = GameManager.player_initial_pos

func _exit_tree() -> void:
	if not blocks.is_empty():
		for block in blocks:
			if GameManager.block_locations.has(block.block_name):
				GameManager.block_locations[block.block_name] = block.global_position

func determine_position() -> void:
	match GameManager.entered_direction:
		GameManager.directions.NORTH:
			current_player.global_position = north_start.global_position
		GameManager.directions.SOUTH:
			current_player.global_position = south_start.global_position
		GameManager.directions.EAST:
			current_player.global_position = east_start.global_position
		GameManager.directions.WEST:
			current_player.global_position = west_start.global_position
	
	GameManager.player_initial_pos = current_player.global_position
