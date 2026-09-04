extends Node2D


func _on_mystery_door_entrance_event_entered(trigger: EventTrigger) -> void:
	print("pindah map")
	SceneTransition.change_scene("res://scenes/maps/mystery_door_map.tscn")



func _on_spawn_beemo_event_entered(trigger: EventTrigger) -> void:
	trigger.activate()
	EventManager.lock_event()

	Dialogic.start("spawn_beemoo")
	await Dialogic.timeline_ended

	var player: Player = $"../Player"
	player.facing_direction = Vector2.DOWN
	player.play_idle_animation()
	player.play_popup_notifications("question")
	GameManager.spawn_followers($"..", Vector2i(player.position.x / 32, 3))

	await get_tree().create_timer(3.0).timeout
	
	Dialogic.start("spawn_beemo")
	await Dialogic.timeline_ended
	player.z_index = 10
	EventManager.unlock_event()


func _on_wrong_way_event_entered(trigger: EventTrigger) -> void:
	EventManager.lock_event()
	Dialogic.start("wrong_way")
	await Dialogic.timeline_ended
	EventManager.unlock_event()
