extends Node2D

@onready var pop_up: AnimatedSprite2D = $PopUp
var animation_y: float = 0.05

func _process(delta: float) -> void:
	pop_up.position.y += animation_y


func _on_timer_timeout() -> void:
	animation_y *= -1

func quest_finished() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
