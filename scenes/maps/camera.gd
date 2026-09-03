extends Camera2D
class_name MyCamera

func camera_animation(to_position: Vector2) -> void:
	EventManager.lock_event()
	var tween := create_tween()
	tween.tween_property(self, "position", to_position, 2.0)\
	.set_trans(Tween.TRANS_LINEAR)\
	.set_ease(Tween.EASE_OUT_IN)
	
	await get_tree().create_timer(3.0).timeout

	var tween2:= create_tween()
	tween2.tween_property(self, "position", Vector2.ZERO, 2.0)\
	.set_trans(Tween.TRANS_LINEAR)\
	.set_ease(Tween.EASE_IN_OUT)
	
	await get_tree().create_timer(2.0).timeout
	EventManager.unlock_event()
