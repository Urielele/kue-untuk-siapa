extends Node2D





func _on_mystery_door_entrance_event_entered(trigger: EventTrigger) -> void:
	print("pindah map")
	pass # Replace with function body.


func _on_spawn_beemo_event_entered(trigger: EventTrigger) -> void:
	trigger.is_active = false
	EventManager.lock_event()

	await get_tree().create_timer(0.3).timeout
	var player = $"../Player"
	player.facing_direction = Vector2.DOWN
	player.play_idle_animation()
	player.play_popup_notifications("question")
	GameManager.spawn_followers($"..", Vector2i(12, 5))

	await get_tree().create_timer(2.0).timeout
	EventManager.unlock_event()
