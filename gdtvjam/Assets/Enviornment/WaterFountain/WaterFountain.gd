extends Node2D

func _ready() -> void:
	var random_start_time: float = randf_range(0.2, 0.5)
	await get_tree().create_timer(random_start_time).timeout
	$Water.play()
	random_start_time = randf_range(0.2, 0.5)
	await get_tree().create_timer(random_start_time).timeout
	$Mist.play()
