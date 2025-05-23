extends Node

@onready var big_tiles: Node2D = %BigTiles
@onready var normal_tiles: TileMapLayer = %NormalFloor


func _process(_delta: float) -> void:
	if (GameManager.current_player_size == GameManager.character_size.SMALL):
		big_tiles.visible = true
		normal_tiles.visible = false
	else:
		big_tiles.visible = false
		normal_tiles.visible = true
