extends AnimatedSprite2D


func on_toggle(is_on: bool):
	if is_on:
		frame = 1
	else:
		frame = 0
	
