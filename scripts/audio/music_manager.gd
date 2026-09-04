extends Node

## Central music manager. Handles crossfading between tracks.
## Maps use @export music_track to play music per scene.

var _player_a: AudioStreamPlayer
var _player_b: AudioStreamPlayer
var _active_player: AudioStreamPlayer
var _inactive_player: AudioStreamPlayer
var _current_track: AudioStream
var _current_volume_db: float = 0.0
var _fade_tween: Tween


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	_player_a = AudioStreamPlayer.new()
	_player_a.name = "MusicPlayerA"
	add_child(_player_a)

	_player_b = AudioStreamPlayer.new()
	_player_b.name = "MusicPlayerB"
	add_child(_player_b)

	_active_player = _player_a
	_inactive_player = _player_b


func play_music(track: AudioStream, volume_db: float = 0.0, fade_time: float = 1.0) -> void:
	if track == null:
		return
	if track == _current_track and _active_player.playing:
		return

	_current_track = track
	_current_volume_db = volume_db

	if _fade_tween and _fade_tween.is_valid():
		_fade_tween.kill()

	_inactive_player.stream = track
	_inactive_player.volume_db = -40.0 if _active_player.playing else volume_db
	_inactive_player.play()

	if _active_player.playing and fade_time > 0.0:
		_fade_tween = create_tween().set_parallel(true)
		_fade_tween.tween_property(_active_player, "volume_db", -40.0, fade_time)
		_fade_tween.tween_property(_inactive_player, "volume_db", volume_db, fade_time)
		_fade_tween.chain().tween_callback(_active_player.stop)
		var tmp := _active_player
		_active_player = _inactive_player
		_inactive_player = tmp
	else:
		if _active_player.playing:
			_active_player.stop()
		_active_player.stream = track
		_active_player.volume_db = volume_db
		_active_player.play()
		var tmp := _active_player
		_active_player = _inactive_player
		_inactive_player = tmp


func stop_music(fade_time: float = 1.0) -> void:
	_current_track = null

	if _fade_tween and _fade_tween.is_valid():
		_fade_tween.kill()

	if _active_player.playing and fade_time > 0.0:
		_fade_tween = create_tween()
		_fade_tween.tween_property(_active_player, "volume_db", -40.0, fade_time)
		_fade_tween.tween_callback(_active_player.stop)
	else:
		_active_player.stop()
		_inactive_player.stop()


func is_playing() -> bool:
	return _active_player.playing or _inactive_player.playing


func get_current_track() -> AudioStream:
	return _current_track
