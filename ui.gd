extends Control

func play():
	get_tree().change_scene_to_file("res://characters/Objects/Survivor_Game.tscn")



func quit_game():
	get_tree().quit()
