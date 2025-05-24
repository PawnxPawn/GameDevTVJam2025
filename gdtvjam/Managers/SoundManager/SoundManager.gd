extends Node2D

@onready var sfx: Node = $SoundFX
@onready var music: Node = $Music
@onready var buttons: Node2D = $Buttons


#SoundFX Tracks
var card_bad_sfx: StringName  = &"CardBadSound"
var card_good_sfx: StringName  = &"CardGoodSound"
var card_flip_sfx: StringName  = &"TestTone"
var lost_life_sfx: StringName  = &"LostLife"
var hover_sfx: StringName  = &"HoverTone"
var test_tone: StringName = &"TestTone"

#Menu Button Tracks
var enter_settings_sound: StringName = &"EnterSettings"
var exit_settings_sound: StringName = &"ExitSettings"
var play_game_sound: StringName = &"PlayGameButton"

#Music Tracks
var main_menu_music: StringName  = &"MainMenu"
var game_music: StringName  = &"GameMusic"
var game_music_double_time: StringName  = &"GameMusicDoubleTime"
var game_over_music: StringName  = &"GameOver"
var game_win_music: StringName  = &"GameWin"
var menu_music: StringName = &"MenuMusic"
var end_menu_music: StringName = &"EndMenuMusic"


func play_sfx(track: StringName) -> void:
	for sound in sfx.get_children():
		if sound.name == track and sound is AkEvent2D:
			var current_node:AkEvent2D = sound as AkEvent2D
			current_node.post_event()
			return
	print("Track not found: ", track)

func play_music(track: StringName) -> void:
	for sound in music.get_children():
		if sound.name == track and sound is AkEvent2D:
			var current_node:AkEvent2D = sound as AkEvent2D
			current_node.post_event()
			return
	print("Track not found: ", track)
	
func play_button(track: StringName) -> void:
	for sound in buttons.get_children():
		if sound.name == track and sound is AkEvent2D:
			var current_node:AkEvent2D = sound as AkEvent2D
			current_node.post_event()
			return
	print("Track not found: ", track)
