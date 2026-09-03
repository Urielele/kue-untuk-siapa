extends CanvasLayer

const FADE_DURATION := 0.5

var color_rect: ColorRect
var _transitioning := false


func _ready() -> void:
	layer = 100
	color_rect = ColorRect.new()
	color_rect.color = Color(0, 0, 0, 0)
	color_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(color_rect)
	color_rect.visible = true


func change_scene(scene_path: String) -> void:
	if _transitioning:
		return
	_transitioning = true
	await _fade_to_black()
	get_tree().change_scene_to_file(scene_path)
	await _fade_from_black()
	_transitioning = false


func _fade_to_black() -> void:
	color_rect.color.a = 0.0
	var tween := create_tween()
	tween.tween_property(color_rect, "color:a", 1.0, FADE_DURATION) \
		.set_trans(Tween.TRANS_LINEAR)
	await tween.finished


func _fade_from_black() -> void:
	color_rect.color.a = 1.0
	var tween := create_tween()
	tween.tween_property(color_rect, "color:a", 0.0, FADE_DURATION) \
		.set_trans(Tween.TRANS_LINEAR)
	await tween.finished
