extends Node2D





func _on_mystery_door_entrance_event_entered(trigger: EventTrigger) -> void:
	print("pindah map")
	pass # Replace with function body.


func _on_spawn_beemo_event_entered(trigger: EventTrigger) -> void:
	
	await get_tree().create_timer(0.2).timeout
	$"../Player".facing_direction = Vector2.DOWN
	$"../Player".play_popup_notifications("question")
	GameManager.spawn_followers($"..", Vector2i(12, 5))
