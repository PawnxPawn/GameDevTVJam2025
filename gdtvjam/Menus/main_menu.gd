extends Control

@onready var level_0 = "uid://hthg2421qwkx"
@onready var credits = "uid://d3a5nng4xkp3l" #EndScreen.tscn
@onready var vbox_container: VBoxContainer = %MenuContainer
@onready var main_menu_player: AnimationPlayer = %MainMenuPlayer

@export var settings_menu: Control
@export var main_menu_control: Control

var play_is_pressed: bool = false


func _ready() -> void:
	AudioManager.level_music.stop()
	main_menu_player.play("MainMenuFadeIn")
	AudioManager.main_menu_music.play()


func _animation_fade_out() -> void:
	main_menu_player.play("MainMenuFadeOut")
	await main_menu_player.animation_finished


func _on_play_game_button_pressed() -> void:
	if not play_is_pressed:
		play_is_pressed = true
		#sound_manager.play_button(sound_manager.play_game_sound)
		await _animation_fade_out()
		AudioManager.main_menu_music.stop()
		play_is_pressed = false
		get_tree().change_scene_to_file(level_0)
	

func show_hide() -> void:
	main_menu_control.visible = !main_menu_control.visible
	settings_menu.visible = !settings_menu.visible


func _on_settings_button_pressed() -> void:
	#sound_manager.play_button(sound_manager.enter_settings_sound)
	show_hide()


func _on_settings_menu_return_control() -> void:
	#sound_manager.play_button(sound_manager.exit_settings_sound)
	show_hide()


func _on_credits_button_pressed() -> void:
	GameManager.is_credits_called = true
	await _animation_fade_out()
	get_tree().change_scene_to_file(credits)
