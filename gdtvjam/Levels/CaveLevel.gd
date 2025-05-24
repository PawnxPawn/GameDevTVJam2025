extends Node


func _ready() -> void:
	if (GameManager.level_first_load):
		GameManager.level_first_load = false
		GameManager.player_size_when_entered = GameManager.current_player_size

	else:
		GameManager.current_player_size = GameManager.player_size_when_entered
