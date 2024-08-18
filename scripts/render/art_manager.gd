extends Node2D

@export var buttons_up: Array[Texture]
@export var buttons_down: Array[Texture]
@export var cut_lines: Array[Texture]
@export var scissors: Array[Texture]
@export var switch_active: Array[Texture]
@export var switch_deactive: Array[Texture]

func get_button(is_up: bool, color: Enums.Colors):
	if is_up:
		return buttons_up[int(color)]
	else:
		return buttons_down[int(color)]

func get_color_wall(active: bool, color: Enums.Colors):
	if active:
		return scissors[int(color)]
	else:
		return cut_lines[int(color)]

func get_switch(active: bool, color: Enums.Colors):
	if active:
		return switch_active[int(color)]
	else:
		return switch_deactive[int(color)]

func get_box():
	pass
