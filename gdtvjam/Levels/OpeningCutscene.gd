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
	animation_player.play("Opening")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") or event.is_action_pressed("pause"):
		ChangeScenes()
		

func show_next_dialogue(index:int) -> void:
	label.text = _dialogue[index]


func remove_dialogue() -> void:
	label.text = ""


func ChangeScenes() -> void:
	get_tree().change_scene_to_file(next_level)
