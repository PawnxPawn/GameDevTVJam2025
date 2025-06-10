extends Control

@onready var level_0 = "uid://hthg2421qwkx" #OpeningCutscene.tscn
@onready var level_1 = "uid://omucjap1o10s" 
@onready var credits = "uid://d3a5nng4xkp3l" #EndScreen.tscn
@onready var vbox_container: VBoxContainer = %MenuContainer
@onready var main_menu_player: AnimationPlayer = %MainMenuPlayer

@export var settings_menu: Control
@export var main_menu_control: Control

var play_is_pressed: bool = false


func _ready() -> void:
	get_tree().paused = false
	AudioManager.level_music.stop()
	main_menu_player.play("MainMenuFadeIn")
	AudioManager.main_menu_music.play()


func _animation_fade_out() -> void:
	main_menu_player.play("MainMenuFadeOut")
	await main_menu_player.animation_finished


func _on_play_game_button_pressed() -> void:
	if not play_is_pressed:
		AudioManager.accept_sfx.play()
		play_is_pressed = true
		#sound_manager.play_button(sound_manager.play_game_sound)
		await _animation_fade_out()
		AudioManager.main_menu_music.stop()
		play_is_pressed = false
		if not GameManager.initial_game_run:
			get_tree().paused = false
			AudioManager.level_music.play()
			GameManager.block_locations["7A"] = Vector2(32, 28)
			get_tree().change_scene_to_file(level_1)
		else:
			get_tree().change_scene_to_file(level_0)
	

func show_hide() -> void:
	main_menu_control.visible = !main_menu_control.visible
	settings_menu.visible = !settings_menu.visible


func _on_settings_button_pressed() -> void:
	AudioManager.accept_sfx.play()
	show_hide()


func _on_settings_menu_return_control() -> void:
	AudioManager.accept_sfx.play()
	show_hide()


func _on_credits_button_pressed() -> void:
	AudioManager.accept_sfx.play()
	GameManager.is_credits_called = true
	await _animation_fade_out()
	get_tree().change_scene_to_file(credits)

func _on_button_hovered() -> void:
	AudioManager.option_hover_sfx.play()
