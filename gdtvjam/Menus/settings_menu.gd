extends Control

@export var volume_sliders: Dictionary[String, HSlider]

signal return_control

func _on_return_button_pressed() -> void:
	AudioManager.accept_sfx.play()
	return_control.emit()


func _on_mouse_entered() -> void:
	AudioManager.option_hover_sfx.play()

func _on_godot_license_pressed() -> void:
	OS.shell_open("")
