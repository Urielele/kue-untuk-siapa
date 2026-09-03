extends Control

func _ready() -> void:
	Dialogic.start("prologue")
	await Dialogic.timeline_ended
	SceneTransition.change_scene("res://scenes/maps/village_map.tscn")
