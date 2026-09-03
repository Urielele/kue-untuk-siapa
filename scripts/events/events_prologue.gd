extends Node2D





func _on_mystery_door_entrance_event_entered(trigger: EventTrigger) -> void:
	print("pindah map")
	pass # Replace with function body.



func _on_spawn_beemo_event_entered(trigger: EventTrigger) -> void:
	trigger.activate()
	EventManager.lock_event()

	Dialogic.start("spawn_beemoo")
	await Dialogic.timeline_ended

	var player: Player = $"../Player"
	player.z_index = 8
	player.facing_direction = Vector2.DOWN
	player.play_idle_animation()
	player.play_popup_notifications("question")
	GameManager.spawn_followers($"..", Vector2i(player.position.x / 32, 3))

	await get_tree().create_timer(3.0).timeout
	
	Dialogic.start("spawn_beemo")
	await Dialogic.timeline_ended
	player.z_index = 10
	EventManager.unlock_event()
