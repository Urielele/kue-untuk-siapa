extends Node2D

@export var spawn_position := Vector2i(12, 2)


func _ready() -> void:
	call_deferred("_setup_map")


func _setup_map() -> void:
	var player := get_node_or_null("Player")
	if player:
		player.position = Vector2(spawn_position) * Vector2(32, 32)
		player.grid_position = spawn_position
	GameManager.spawn_followers(self, Vector2i(12, 3))
