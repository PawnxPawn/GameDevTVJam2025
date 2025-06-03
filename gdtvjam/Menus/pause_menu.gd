extends Control

@onready var credits = "uid://bvcy6tqectio2" #credits.tscn

@export var main_menu: PackedScene
@export var settings_menu: Control
@export var pause_menu_control: Control

func _ready() -> void:
	pause_menu_control.visible = false


func _unhandled_input(_event: InputEvent) -> void:
	if (Input.is_action_just_pressed("pause")):
		if (get_tree().paused && settings_menu.visible):
			show_hide()
		else:
			toggle_pause()


func toggle_pause() -> void:
	get_tree().paused = !get_tree().paused
	pause_menu_control.visible = !pause_menu_control.visible


func _on_resume_button_pressed() -> void:
	pause_menu_control.visible = false
	get_tree().paused = false


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)


func show_hide() -> void:
	settings_menu.visible = !settings_menu.visible
	pause_menu_control.visible = !pause_menu_control.visible


func _on_settings_button_pressed() -> void:
	show_hide()


func _on_settings_menu_return_control() -> void:
	show_hide()


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file(credits)

	
