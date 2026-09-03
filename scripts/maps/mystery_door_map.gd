extends Node2D

@export var spawn_position := Vector2i(12, 2)
@onready var camera_2d: MyCamera = $Player/Camera2D


func _ready() -> void:
	call_deferred("_setup_map")
	await get_tree().create_timer(0.75).timeout
	camera_2d.camera_animation(Vector2(120.0, -325.0))


func _setup_map() -> void:
	var player := get_node_or_null("Player")
	if player:
		player.position = Vector2(spawn_position) * Vector2(32, 32)
		player.grid_position = spawn_position
		player.facing_direction = Vector2.UP
		player.play_idle_animation()
	GameManager.spawn_followers(self, Vector2i(12, 3))
