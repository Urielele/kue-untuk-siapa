extends CanvasLayer

@onready var party_container: VBoxContainer = $MarginContainer/PanelContainer/VBoxContainer


func _ready() -> void:
	GameManager.party_changed.connect(_update_display)
	_update_display()


func _update_display() -> void:
	for child in party_container.get_children():
		child.queue_free()

	for i in range(GameManager.party.size()):
		var member := GameManager.get_member(i)
		var row := _create_member_row(member)
		party_container.add_child(row)


func _create_member_row(member: Dictionary) -> PanelContainer:
	var panel := PanelContainer.new()
	var hbox := HBoxContainer.new()
	hbox.add_theme_constant_override("separation", 16)

	var name_label := Label.new()
	name_label.text = member.get("name", "???")
	name_label.custom_minimum_size.x = 100

	var hp_label := Label.new()
	hp_label.text = "HP: %d/%d" % [member.get("hp", 0), member.get("max_hp", 0)]

	var ep_label := Label.new()
	ep_label.text = "EP: %d/%d" % [member.get("ep", 0), member.get("max_ep", 0)]

	hbox.add_child(name_label)
	hbox.add_child(hp_label)
	hbox.add_child(ep_label)
	panel.add_child(hbox)
	return panel
