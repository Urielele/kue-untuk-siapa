extends Control

@export var music_track: AudioStream
@export var music_volume_db: float = 0.0
@export var music_fade_time: float = 1.0


func _ready() -> void:
	if music_track:
		MusicManager.play_music(music_track, music_volume_db, music_fade_time)
	Dialogic.start("prologue")
	await Dialogic.timeline_ended
	SceneTransition.change_scene("res://scenes/maps/village_map.tscn")


func _exit_tree() -> void:
	if music_track:
		MusicManager.stop_music(music_fade_time)
