extends Node2D

@export var spawn_position := Vector2i(12, 0)
@export var music_track: AudioStream
@export var music_volume_db: float = 0.0
@export var music_fade_time: float = 1.0


func _ready() -> void:
	call_deferred("_setup_map")
	if music_track:
		MusicManager.play_music(music_track, music_volume_db, music_fade_time)


func _exit_tree() -> void:
	if music_track:
		MusicManager.stop_music(music_fade_time)


func _setup_map() -> void:
	var player := get_node_or_null("Player")
	if player:
		player.position = Vector2(spawn_position) * Vector2(32, 32)
		player.grid_position = spawn_position
	#GameManager.spawn_followers(self, spawn_position)
