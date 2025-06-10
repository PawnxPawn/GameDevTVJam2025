extends Control

@onready var main_menu_scene: StringName = &"res://Menus/MainMenu.tscn"

func _input(_event: InputEvent) -> void:
	if Input.is_anything_pressed():
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			get_tree().change_scene_to_file(main_menu_scene)
