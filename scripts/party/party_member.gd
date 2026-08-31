extends Node2D
class_name PartyMember

const GRID_SIZE := Vector2(32, 32)
const MOVE_DURATION := 0.1

var grid_position := Vector2i.ZERO
var follow_index: int = 0
var is_moving := false
var member_data: Dictionary = {}

var _target_grid := Vector2i.ZERO
var _has_target := false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	add_to_group("party_members")
	_snap_to_grid()
	_target_grid = grid_position


func _physics_process(_delta: float) -> void:
	if is_moving or _has_target:
		return

	var player: Node2D = _get_player()
	if not player:
		return

	var history: Array[Vector2i] = player.movement_history
	var needed_index := follow_index + 1

	if history.size() > needed_index:
		var target: Vector2i = history[needed_index]
		if target != grid_position:
			_target_grid = target
			_has_target = true
			_move_to_target()


func _move_to_target() -> void:
	is_moving = true
	var target_pos := Vector2(_target_grid) * GRID_SIZE
	var dir := _target_grid - grid_position
	_play_walk_animation(dir)

	var tween := create_tween()
	tween.tween_property(self, "position", target_pos, MOVE_DURATION) \
		.set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(_on_move_complete)


func _on_move_complete() -> void:
	grid_position = _target_grid
	_has_target = false
	is_moving = false
	_play_idle_animation()


func setup(data: Dictionary, index: int) -> void:
	member_data = data
	follow_index = index
	name = data.get("name", "Party%d" % index)


func teleport_to(pos: Vector2i) -> void:
	grid_position = pos
	_target_grid = pos
	position = Vector2(pos) * GRID_SIZE
	_play_idle_animation()


func _get_player():
	return get_tree().get_first_node_in_group("player")


func _snap_to_grid() -> void:
	grid_position = Vector2i(
		roundi(position.x / GRID_SIZE.x),
		roundi(position.y / GRID_SIZE.y)
	)
	position = Vector2(grid_position) * GRID_SIZE


func _play_walk_animation(dir: Vector2) -> void:
	if not sprite or not sprite.sprite_frames:
		return
	var anim_name := "walk_%s" % _direction_name(dir)
	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)


func _play_idle_animation() -> void:
	if not sprite or not sprite.sprite_frames:
		return
	var anim_name := "idle_down"
	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)


func _direction_name(dir: Vector2) -> String:
	if dir == Vector2.UP:
		return "up"
	elif dir == Vector2.DOWN:
		return "down"
	elif dir == Vector2.LEFT:
		return "left"
	elif dir == Vector2.RIGHT:
		return "right"
	return "down"
