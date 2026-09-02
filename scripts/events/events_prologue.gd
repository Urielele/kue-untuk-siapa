extends Node2D





func _on_mystery_door_entrance_event_entered(trigger: EventTrigger) -> void:
	print("pindah map")
	pass # Replace with function body.


func _on_spawn_beemo_event_entered(trigger: EventTrigger) -> void:
	GameManager.spawn_followers($"..", Vector2i(12, 5))
	pass # Replace with function body.
