extends Node

@onready var label: Label = %IntoLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var next_level: StringName

var _dialogue: Array[String] = [
	"\"...Come find me...\"",
	"I don't remember this cave being here before.",
]

var scene: PackedScene

func _ready() -> void:
	GameManager.initial_game_run = true
	scene = load(next_level)
	animation_player.play("Opening")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") or event.is_action_pressed("pause"):
		ChangeScenes()
		

func show_next_dialogue(index:int) -> void:
	label.text = _dialogue[index]


func remove_dialogue() -> void:
	label.text = ""


func ChangeScenes() -> void:
	if scene:
		var new_scene = scene.instantiate()
		get_tree().change_scene_to(new_scene)
