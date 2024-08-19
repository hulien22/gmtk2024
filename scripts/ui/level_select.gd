extends Control

@export var level_scene: PackedScene

var cur_level:int = 0
var animating:bool = false


func _ready() -> void:
	AudioManager.set_level_select(true)
	cur_level = WorldState.active_level
	
	for i in %Levels.get_child_count():
		if i <= WorldState.num_stars:
			(%Levels.get_child(i) as Sprite2D).modulate.a = 1.0
		else:
			(%Levels.get_child(i) as Sprite2D).modulate.a = 0.5
	
	MoveStuff()
	
	if WorldState.first_load:
		WorldState.first_load = false
	else:
		animating = true
		PlayLeaveLevelAnim()


func _input(event):
	if animating:
		return
	if event.is_action_pressed("ui_up"):
		var target_level = (cur_level + 5) % 10
		if target_level <= WorldState.num_stars:
			cur_level = target_level
			MoveStuff()
		else:
			AudioManager.play_denied()
	elif event.is_action_pressed("ui_down"):
		var target_level = (cur_level + 5) % 10
		if target_level <= WorldState.num_stars:
			cur_level = target_level
			MoveStuff()
		else:
			AudioManager.play_denied()
	if event.is_action_pressed("ui_right"):
		var target_level = (cur_level + 1) % 10
		if target_level <= WorldState.num_stars:
			cur_level = target_level
			MoveStuff()
		else:
			AudioManager.play_denied()
	if event.is_action_pressed("ui_left"):
		var target_level = (cur_level + 9) % 10
		if target_level <= WorldState.num_stars:
			cur_level = target_level
			MoveStuff()
		else:
			AudioManager.play_denied()
	elif event.is_action_pressed("ui_accept"):
		animating = true
		WorldState.active_level = cur_level
		PlayEnterLevelAnim()
		
	#cur_level = (cur_level % 10 + 1)
	#MoveStuff()
	pass

func MoveStuff():
	var level = %Levels.get_children()[cur_level] as Sprite2D
	%Sprite.global_position = level.global_position + Vector2(5, -100)

func PlayEnterLevelAnim():
	%Sprite.frame = 1
	%LittleGuy.position = Vector2(0,0)
	%LittleGuy.scale = Vector2(0.0001, 0.0001)
	%LittleGuy.show()
	var tween = create_tween()
	tween.tween_property(%LittleGuy, "position", Vector2(0, 100), 0.5).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(%LittleGuy, "scale", Vector2(0.5, 0.5), 0.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(%LittleGuy, "position", Vector2(0, 200), 0.5).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(%LittleGuy, "scale", Vector2(0.001,0.001), 0.5).set_ease(Tween.EASE_IN)
	tween.tween_callback(GoToLevel)
	AudioManager.play_spit()

func GoToLevel():
	AudioManager.set_level_select(false) 
	get_tree().change_scene_to_packed(level_scene)

func PlayLeaveLevelAnim():
	%Sprite.frame = 1
	%LittleGuy.position = Vector2(0,200)
	%LittleGuy.scale = Vector2(0.0001, 0.0001)
	%LittleGuy.show()
	var tween = create_tween()
	tween.tween_property(%LittleGuy, "position", Vector2(0, 100), 0.5).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(%LittleGuy, "scale", Vector2(0.5, 0.5), 0.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(%LittleGuy, "position", Vector2(0, 0), 0.5).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(%LittleGuy, "scale", Vector2(0.001,0.001), 0.5).set_ease(Tween.EASE_IN)
	tween.tween_callback(AllowControls)
	AudioManager.play_swallow()

func AllowControls():
	%Sprite.frame = 0
	animating = false
