extends EventTrigger

@export var npc_name: String = "NPC"
@export var dialog_id: String = ""
@export var face_player: bool = true


func activate() -> void:
	if not is_active:
		return

	if face_player:
		_face_toward_player()

	if dialog_id != "":
		EventManager.start_dialog(dialog_id)

	super.activate()


func _face_toward_player() -> void:
	var player := get_tree().get_first_node_in_group("player")
	if not player:
		return
	var dir = (player.global_position - global_position).normalized()
	if abs(dir.x) > abs(dir.y):
		facing_direction = Vector2(sign(dir.x), 0)
	else:
		facing_direction = Vector2(0, sign(dir.y))
