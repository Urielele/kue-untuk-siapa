extends Node2D


func _on_hyacinth_trigger_event_activated(trigger: EventTrigger) -> void:
	EventManager.lock_event()
	Dialogic.start("hyacinth_question")
	await Dialogic.timeline_ended
	EventManager.unlock_event()
	$"../NPCs/Hyacinth".quest_finished()


func _on_red_trigger_event_activated(trigger: EventTrigger) -> void:
	EventManager.lock_event()
	Dialogic.start("red_question")
	await Dialogic.timeline_ended
	EventManager.unlock_event()
	$"../NPCs/Red".quest_finished()


func _on_birthdate_trigger_event_activated(trigger: EventTrigger) -> void:
	EventManager.lock_event()
	Dialogic.start("birthdate_question")
	await Dialogic.timeline_ended
	EventManager.unlock_event()
	$"../NPCs/Birthdate".quest_finished()


func _on_mbti_trigger_event_activated(trigger: EventTrigger) -> void:
	EventManager.lock_event()
	Dialogic.start("intj_question")
	await Dialogic.timeline_ended
	EventManager.unlock_event()
	$"../NPCs/MBTI".quest_finished()


func _on_door_trigger_event_activated(trigger: EventTrigger) -> void:
	EventManager.lock_event()
	
	if GameManager.keys_collected == 0:
		Dialogic.start("first_mysterious_door")
		await  Dialogic.timeline_ended
		$"../NPCs".visible = true
	elif not GameManager.check_key():
		Dialogic.start("mysterious_door")
		await  Dialogic.timeline_ended
	else:
		pass
	
	EventManager.unlock_event()
