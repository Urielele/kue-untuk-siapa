extends Node

## Modular soundtrack node. Place this in any map scene and assign a music track.
## The music will play when the node enters the tree and stop when it exits.
##
## Usage: Instance this node in a map scene, then set the music_track export
## to your .ogg/.wav/.mp3 file in the inspector.

@export var music_track: AudioStream
@export var volume_db: float = 0.0
@export var fade_time: float = 1.0
@export var loop: bool = true


func _ready() -> void:
	if music_track:
		MusicManager.play_music(music_track, volume_db, fade_time)


func _exit_tree() -> void:
	if music_track:
		MusicManager.stop_music(fade_time)
