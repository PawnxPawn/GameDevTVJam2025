extends RigidBody2D

@onready var interactable : Interactable
@onready var push_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var normal_tiles: TileMapLayer
@export var block_name: StringName


func _physics_process(_delta: float) -> void:
	if normal_tiles:
		var cell := normal_tiles.local_to_map(position)
		var data: TileData = normal_tiles.get_cell_tile_data(cell)
		if (data != null):
			var destroy_block: bool = data.get_custom_data("destroy_block")
			if (destroy_block):
				visible = false
				$CollisionShape2D.disabled = true
	
	if linear_velocity.length() > 0.1 and not push_sfx.playing:
		push_sfx.play()
	
	if linear_velocity.length() < 0.1 and push_sfx.playing:
		push_sfx.stop()