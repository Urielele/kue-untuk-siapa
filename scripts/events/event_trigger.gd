extends Area2D
class_name EventTrigger

signal event_entered(trigger: EventTrigger)
signal event_exited(trigger: EventTrigger)
signal event_activated(trigger: EventTrigger)

@export var event_id: String = ""
@export_enum("dialog", "npc", "door", "chest", "battle") var event_type: String = "dialog"
@export var one_shot: bool = false

var is_active: bool = true
var player_inside: bool = false
var facing_direction := Vector2.DOWN
var player: Player


func _ready() -> void:
	if event_id == "":
		event_id = name
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func activate() -> void:
	if not is_active:
		return
	event_activated.emit(self)
	if one_shot:
		is_active = false


func deactivate() -> void:
	is_active = false


func reactivate() -> void:
	is_active = true


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		player_inside = true
		event_entered.emit(self)


func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		player_inside = false
		event_exited.emit(self)
