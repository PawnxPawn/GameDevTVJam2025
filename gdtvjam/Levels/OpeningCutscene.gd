extends Node

@onready var label: Label = %IntoLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var next_level: StringName

var _dialogue: Array[String] = [
	"\"...Come find me...\"",
	"The cave whispers to you through the wind, beckoning you in.",
	"As you enter the cave, a wave of nostalgia washes over you."
]

var scene: PackedScene

func _ready() -> void:
	AudioManager.level_music.play()
	GameManager.entered_direction = GameManager.directions.SOUTH
	GameManager.initial_game_run = true
	GameManager.has_initial_entrance_scene_ran = false 
	GameManager.room_reset = false
	GameManager.first_room_reset = true
	GameManager.first_shrink = true
	GameManager.first_grow = true
	GameManager.has_won = false
	get_tree().paused = false


	for block in GameManager.block_locations:
		GameManager.block_locations[block] = GameManager.DEFAULT_BLOCK_LOCATIONS[block]
	animation_player.play("Opening")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") or event.is_action_pressed("pause"):
		ChangeScenes()
		

func show_next_dialogue(index:int) -> void:
	label.text = _dialogue[index]


func remove_dialogue() -> void:
	label.text = ""


func ChangeScenes() -> void:
	animation_player.stop()
	get_tree().change_scene_to_file(next_level)
