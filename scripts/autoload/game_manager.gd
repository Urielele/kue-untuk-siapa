extends Node

signal party_changed

var party: Array[Dictionary] = []
var game_flags: Dictionary = {}
var current_map: String = ""

var _followers: Array[PartyMember] = []
var _party_scene: PackedScene = preload("res://scenes/party/party_member.tscn")


func _ready() -> void:
	_init_default_party()


func _init_default_party() -> void:
	party = [
		{
			"name": "Hero",
			"hp": 25,
			"max_hp": 25,
			"ep": 10,
			"max_ep": 10,
			"level": 1,
			"has_body": true,
		},
		{
			"name": "Ally",
			"hp": 18,
			"max_hp": 18,
			"ep": 12,
			"max_ep": 12,
			"level": 1,
			"has_body": false,
		},
	]


func spawn_followers(parent: Node2D, start_pos: Vector2i) -> void:
	_clear_followers()
	for i in range(party.size()):
		if party[i].get("has_body", false):
			continue
		var member: PartyMember = _party_scene.instantiate()
		member.setup(party[i], i)
		member.teleport_to(start_pos)
		parent.add_child(member)
		_followers.append(member)


func add_party_member(member: Dictionary) -> void:
	party.append(member)
	party_changed.emit()


func remove_party_member(index: int) -> void:
	if index >= 0 and index < party.size():
		party.remove_at(index)
		party_changed.emit()


func get_party() -> Array[Dictionary]:
	return party


func get_member(index: int) -> Dictionary:
	if index >= 0 and index < party.size():
		return party[index]
	return {}


func set_flag(flag_name: String, value: Variant) -> void:
	game_flags[flag_name] = value


func get_flag(flag_name: String, default: Variant = false) -> Variant:
	return game_flags.get(flag_name, default)


func change_hp(index: int, amount: int) -> void:
	if index < 0 or index >= party.size():
		return
	party[index]["hp"] = clampi(party[index]["hp"] + amount, 0, party[index]["max_hp"])
	party_changed.emit()


func change_ep(index: int, amount: int) -> void:
	if index < 0 or index >= party.size():
		return
	party[index]["ep"] = clampi(party[index]["ep"] + amount, 0, party[index]["max_ep"])
	party_changed.emit()


func _clear_followers() -> void:
	for f in _followers:
		if is_instance_valid(f):
			f.queue_free()
	_followers.clear()
