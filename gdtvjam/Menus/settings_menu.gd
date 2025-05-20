extends Control

@export var volume_sliders: Dictionary[String, HSlider]

signal return_control

func _on_return_button_pressed() -> void:
# 	for key in volume_sliders:
# 		ConfigFileHandler.save_audio_settings("audio", key, volume_sliders[key].value)	
	return_control.emit()


func _on_mouse_exited() -> void:
	pass

func _on_godot_license_pressed() -> void:
	OS.shell_open("")
