extends Node2D

var music_player: AudioStreamPlayer
var music_volume_percent: float = 1.0
var sfx_volume_percent: float = 1.0

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.stream = load("res://music/upbeat_756v2.ogg") 
	music_player.bus = "music"
	add_child(music_player)

func play_music():
	music_player.play()

func stop_music():
	music_player.stop()

func play_sfx(sound_path: String) -> void:
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = load(sound_path)
	sfx_player.bus = "sfx"
	add_child(sfx_player)
	sfx_player.play()
	sfx_player.finished.connect(func(): sfx_player.queue_free())
	
