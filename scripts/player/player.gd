extends Node2D
class_name Player

const GRID_SIZE := Vector2(32, 32)
const MOVE_DURATION := 0.2

var grid_position := Vector2i.ZERO
var facing_direction := Vector2.DOWN
var is_moving := false
var movement_history: Array[Vector2i] = []
var can_move := true

const HISTORY_MAX := 64

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pop_up: AnimatedSprite2D = $PopUp

func _ready() -> void:
	add_to_group("player")
	_snap_to_grid()
	movement_history.push_front(grid_position)
	_update_depth()



func _physics_process(_delta: float) -> void:
	if is_moving or EventManager.is_event_active:
		return


	var input := _get_input()
	if input != Vector2.ZERO:
		facing_direction = _snap_to_axis(input)
		_play_walk_animation()
		_try_move(facing_direction)
	elif Input.is_action_just_pressed("interact"):
		_interact()


func _try_move(direction: Vector2) -> void:
	var target_grid := grid_position + Vector2i(direction)

	if not _is_cell_walkable(target_grid):
		play_idle_animation()
		return

	is_moving = true
	var target_pos := Vector2(target_grid) * GRID_SIZE

	var tween := create_tween()
	tween.tween_property(self, "position", target_pos, MOVE_DURATION) \
		.set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(_on_move_complete.bind(target_grid))


func _on_move_complete(new_grid_pos: Vector2i) -> void:
	grid_position = new_grid_pos
	position = Vector2(grid_position) * GRID_SIZE
	movement_history.push_front(grid_position)
	if movement_history.size() > HISTORY_MAX:
		movement_history.resize(HISTORY_MAX)
	is_moving = false
	_update_depth()

	if EventManager.is_event_active:
		play_idle_animation()
		return

	var input := _get_input()
	if input != Vector2.ZERO:
		facing_direction = _snap_to_axis(input)
		_play_walk_animation()
		_try_move(facing_direction)
	else:
		play_idle_animation()


func _get_input() -> Vector2:
	var input := Vector2.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.y = Input.get_axis("move_up", "move_down")
	return input


func _interact() -> void:
	EventManager.check_interaction(grid_position, facing_direction)


func _is_cell_walkable(cell: Vector2i) -> bool:
	var space_state := get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = Vector2(cell) * GRID_SIZE + GRID_SIZE * 0.5
	query.collision_mask = 1
	var result := space_state.intersect_point(query)
	return result.is_empty()


func _snap_to_grid() -> void:
	grid_position = Vector2i(
		roundi(position.x / GRID_SIZE.x),
		roundi(position.y / GRID_SIZE.y)
	)
	position = Vector2(grid_position) * GRID_SIZE


func _snap_to_axis(dir: Vector2) -> Vector2:
	if abs(dir.x) > abs(dir.y):
		return Vector2(sign(dir.x), 0)
	elif abs(dir.y) > abs(dir.x):
		return Vector2(0, sign(dir.y))
	return facing_direction


func _play_walk_animation() -> void:
	if not sprite or not sprite.sprite_frames:
		return
	var anim_name := "walk_%s" % _direction_name(facing_direction)
	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)


func play_idle_animation() -> void:
	if not sprite or not sprite.sprite_frames:
		return
	var anim_name := "idle_%s" % _direction_name(facing_direction)
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


func _update_depth() -> void:
	z_index = int(global_position.y/32)


func play_popup_notifications(animation: String) -> void:
	pop_up.visible = true
	pop_up.play(animation)
	pop_up.scale = Vector2.ZERO

	await get_tree().process_frame

	#In animation
	var tween = create_tween()
	tween.tween_property(pop_up, "scale", Vector2.ONE, 0.5)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)

	await get_tree().create_timer(1.5).timeout

	#Out animation
	var tween2 = create_tween()
	tween2.tween_property(pop_up, "scale", Vector2.ZERO, 0.3)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_IN)

	await tween2.finished

	pop_up.visible = false
