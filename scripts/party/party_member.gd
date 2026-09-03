extends Node2D
class_name PartyMember

const GRID_SIZE := Vector2(32, 32)
const MOVE_DURATION := 0.2

var grid_position := Vector2i.ZERO
var follow_index: int = 0
var is_moving := false
var member_data: Dictionary = {}
var facing_direction := Vector2i.DOWN

var _target_grid := Vector2i.ZERO
var _has_target := false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	add_to_group("party_members")
	_snap_to_grid()
	_target_grid = grid_position


func _physics_process(_delta: float) -> void:
	#if is_moving or _has_target or EventManager.is_event_active:
	if is_moving or _has_target:
		return
	_follow_path()


func _follow_path() -> void:
	var history := _get_player_history()
	var anchor := follow_index

	if history.size() <= anchor:
		return

	var goal := history[anchor]
	if goal == grid_position:
		return

	var dir := _snap_to_axis(goal - grid_position)
	if dir == Vector2i.ZERO:
		return

	var step := grid_position + dir
	_target_grid = step
	_has_target = true
	_move_to_target()


func _move_to_target() -> void:
	is_moving = true
	var target_pos := Vector2(_target_grid) * GRID_SIZE
	facing_direction = _target_grid - grid_position
	_play_walk_animation()

	var tween := create_tween()
	tween.tween_property(self, "position", target_pos, MOVE_DURATION) \
		.set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(_on_move_complete)


func _on_move_complete() -> void:
	grid_position = _target_grid
	position = Vector2(grid_position) * GRID_SIZE
	_has_target = false
	is_moving = false

	var history := _get_player_history()
	var anchor := follow_index

	if history.size() > anchor:
		var goal := history[anchor]
		var dir := _snap_to_axis(goal - grid_position)
		if dir != Vector2i.ZERO and goal != grid_position:
			var step := grid_position + dir
			_target_grid = step
			_has_target = true
			_move_to_target()
			return

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


func _get_player_history() -> Array[Vector2i]:
	var player: Node2D = get_tree().get_first_node_in_group("player")
	if not player:
		return []
	var raw = player.get("movement_history")
	var history: Array[Vector2i] = []
	for h in raw:
		history.append(h)
	return history


func _snap_to_grid() -> void:
	grid_position = Vector2i(
		roundi(position.x / GRID_SIZE.x),
		roundi(position.y / GRID_SIZE.y)
	)
	position = Vector2(grid_position) * GRID_SIZE


func _snap_to_axis(dir: Vector2i) -> Vector2i:
	if abs(dir.x) > abs(dir.y):
		return Vector2i(sign(dir.x), 0)
	elif abs(dir.y) > abs(dir.x):
		return Vector2i(0, sign(dir.y))
	return Vector2i.ZERO


func _play_walk_animation() -> void:
	if not sprite or not sprite.sprite_frames:
		return
	var anim_name := "walk_%s" % _direction_name(facing_direction)
	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)


func _play_idle_animation() -> void:
	if not sprite or not sprite.sprite_frames:
		return
	var anim_name := "idle_%s" % _direction_name(facing_direction)
	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)
	else:
		var fallback := "idle_down"
		if sprite.sprite_frames.has_animation(fallback):
			sprite.play(fallback)


func _direction_name(dir: Vector2i) -> String:
	if dir == Vector2i.UP:
		return "up"
	elif dir == Vector2i.DOWN:
		return "down"
	elif dir == Vector2i.LEFT:
		return "left"
	elif dir == Vector2i.RIGHT:
		return "right"
	return "down"
