extends Control

func _ready():
	%Main_Menu.visible = true
	%Settings_Menu.visible = false

func play():
	get_tree().change_scene_to_file("res://characters/Objects/Survivor_Game.tscn")
	AudioManager.play_music()

func _on_play_pressed() -> void:
	play()

func quit_game():
	get_tree().quit()

func _on_quit_pressed() -> void:
	quit_game()
	
	
func toggle_visibility(object):
	if object.visible:
		object.visible = false
	else:
			object.visible = true

func _on_settings_pressed() -> void:
	toggle_visibility(%Main_Menu)
	toggle_visibility(%Settings_Menu)


func _on_settings_back_pressed() -> void:
	_on_settings_pressed() #works same way as settings press
	AudioManager.stop_music()


func _on_button_pressed() -> void:
	AudioManager.play_sfx("res://music/mutantdie.wav")




func _on_music_play_pressed() -> void:
	AudioManager.play_music()


func _on_music_stop_pressed() -> void:
	AudioManager.stop_music()
