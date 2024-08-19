extends Control

@export var level_select_scene: PackedScene

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_packed(level_select_scene)
