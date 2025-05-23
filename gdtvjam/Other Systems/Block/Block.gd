extends RigidBody2D

@export var normal_tiles: TileMapLayer

@onready var interactable : Interactable

func _process(_delta: float) -> void:
	var cell := normal_tiles.local_to_map(position)
	var data: TileData = normal_tiles.get_cell_tile_data(cell)
	if (data != null):
		var destroy_block: bool = data.get_custom_data("destroy_block")
		if (destroy_block):
			call_deferred("queue_free")