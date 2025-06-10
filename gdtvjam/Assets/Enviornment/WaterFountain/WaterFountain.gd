extends Node2D

@export var min_pitch = 0.8
@export var max_pitch = 1.2

func _ready() -> void:
	var random_pitch: float = randf_range(min_pitch, max_pitch)
	$FountainSound.pitch_scale = random_pitch
	$FountainSound.play()
	var random_start_time: float = randf_range(0.2, 0.5)
	await get_tree().create_timer(random_start_time).timeout
	$Water.play()
	random_start_time = randf_range(0.2, 0.5)
	await get_tree().create_timer(random_start_time).timeout
	$Mist.play()
