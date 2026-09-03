extends Node

signal dialog_started
signal dialog_ended
signal event_active_changed(is_active: bool)

var is_event_active: bool = false
var _active_events: Array[EventTrigger] = []


func start_dialog(dialog_id: String) -> void:
	if dialog_id == "":
		return
	_set_event_active(true)
	dialog_started.emit()
	print("[EventManager] Dialog started: ", dialog_id)
	Dialogic.start(dialog_id)
	await Dialogic.timeline_ended
	end_dialog()


func end_dialog() -> void:
	dialog_ended.emit()
	_set_event_active(false)
	print("[EventManager] Dialog ended")


func start_battle(_enemy_data: Dictionary) -> void:
	_set_event_active(true)
	print("[EventManager] Battle started (not implemented yet)")


func end_battle() -> void:
	_set_event_active(false)
	print("[EventManager] Battle ended")


func check_interaction(player_grid: Vector2i, facing: Vector2) -> void:
	var target_grid := player_grid + Vector2i(facing)
	var triggers := get_tree().get_nodes_in_group("event_triggers")

	for trigger in triggers:
		if trigger is EventTrigger and trigger.player_inside and trigger.is_active:
			trigger.activate()
			return


func register_trigger(trigger: EventTrigger) -> void:
	if trigger not in _active_events:
		_active_events.append(trigger)


func unregister_trigger(trigger: EventTrigger) -> void:
	_active_events.erase(trigger)


func lock_event() -> void:
	_set_event_active(true)


func unlock_event() -> void:
	_set_event_active(false)


func _set_event_active(active: bool) -> void:
	is_event_active = active
	event_active_changed.emit(is_event_active)
