extends Node2D

var level: Level


#var levelstr: Array[String] = [
	#".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  w  w  w  w  .  CG .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  w  w  w  w  .  CG .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  XS .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  XM .  .  .  .  .  w  w  w  w  .  .  .  .  PB .  .  .  .  .  .  .  CBR.  .  .  FB .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	#"SBM.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  XB .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  BGM.  .  .  CBR.  BGM.  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
#]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LoadLevel()

func LoadLevel():
	level = WorldState.levels[WorldState.active_level]
	%Camera2D.zoom = Vector2.ONE * WorldState.level_infos[WorldState.active_level].camera_zoom
	%Camera2D.offset = WorldState.level_infos[WorldState.active_level].camera_offset
	%BgTiles.position = WorldState.level_infos[WorldState.active_level].bg_tile_posn
	%BgTiles.size = WorldState.level_infos[WorldState.active_level].bg_tile_size
	level.rendered_level = $RenderedLevel
	level.leave_level.connect(LeaveLevel)
	$RenderedLevel.init(level)
	await get_tree().create_timer(AnimationConstants.LONG_ANIM).timeout
	level.StartLevel()
	
	var timer = get_tree().create_timer(AnimationConstants.LONG_ANIM)
	timer.timeout.connect(EnableMovement)

func EnableMovement():
	is_animating = false

var is_animating:bool = true
var last_input_pressed: String = ""
var time_since_last_input_pressed: float = 0
@export var INPUT_DELAY: float = 0.15

func _process(delta: float) -> void:
	if is_animating:
		return
	
	var new_input: String = ""
	if Input.is_action_pressed("ui_up"):
		new_input = "ui_up"
	elif Input.is_action_pressed("ui_down"):
		new_input = "ui_down"
	elif Input.is_action_pressed("ui_right"):
		new_input = "ui_right"
	elif Input.is_action_pressed("ui_left"):
		new_input = "ui_left"
	elif Input.is_action_pressed("ui_accept"):
		new_input = "ui_accept"
	elif Input.is_action_pressed("ToggleSwitch"):
		new_input = "ToggleSwitch"
	elif Input.is_action_pressed("Undo"):
		new_input = "Undo"
	elif Input.is_action_pressed("ResetLevel"):
		new_input = "ResetLevel"
	elif Input.is_action_pressed("ReturnToLevelSelect"):
		new_input = "ReturnToLevelSelect"
	
	if new_input == "":
		last_input_pressed = ""
		time_since_last_input_pressed = 0
		return
	
	if new_input == last_input_pressed:
		time_since_last_input_pressed += delta
		if time_since_last_input_pressed < INPUT_DELAY:
			return
		time_since_last_input_pressed = 0
	else:
		last_input_pressed = new_input
		time_since_last_input_pressed = 0

	var update: bool = false
	is_animating = true
	match new_input:
		("ui_up"):
			update = level.TryMove(Enums.Direction.UP)
		("ui_down"):
			update = level.TryMove(Enums.Direction.DOWN)
		("ui_right"):
			update = level.TryMove(Enums.Direction.RIGHT)
		("ui_left"):
			update = level.TryMove(Enums.Direction.LEFT)
		("ui_accept"):
			update = level.TrySummon()
		("ToggleSwitch"):
			update = level.TryToggleSwitch()
		("Undo"):
			update = level.Undo()
		("ResetLevel"):
			update = level.Reset()
		("ReturnToLevelSelect"):
			if (level.LeaveLevel()):
			#if level.CurrentState().player.size == TileObj.TileSize.BIG:
				await get_tree().create_timer(AnimationConstants.LONG_ANIM * 2).timeout
				get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")
				return
			else:
				# show message about too small?
				pass
				#is_animating = false
				#return
	if update:
		AudioManager.set_size(level.CurrentState().player.size)
		level.DEBUG_PrintState(level.CurrentState())
	else:
		AudioManager.play_denied()
	is_animating = false

#
#func _input(event):
	#var update: bool = false
	#if event.is_action_pressed("ui_up"):
		#update = level.TryMove(Enums.Direction.UP)
	#elif event.is_action_pressed("ui_down"):
		#update = level.TryMove(Enums.Direction.DOWN)
	#elif event.is_action_pressed("ui_right"):
		#update = level.TryMove(Enums.Direction.RIGHT)
	#elif event.is_action_pressed("ui_left"):
		#update = level.TryMove(Enums.Direction.LEFT)
	#elif event.is_action_pressed("ui_accept"):
		#update = level.TrySummon()
	#elif event.is_action_pressed("ToggleSwitch"):
		#update = level.TryToggleSwitch()
	#elif event.is_action_pressed("Undo"):
		#update = level.Undo()
	#elif event.is_action_pressed("ResetLevel"):
		#update = level.Reset()
	#elif event.is_action_pressed("ReturnToLevelSelect"):
		#if (level.LeaveLevel()):
		##if level.CurrentState().player.size == TileObj.TileSize.BIG:
			#await get_tree().create_timer(AnimationConstants.LONG_ANIM * 2).timeout
			#get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")
			#return
		#else:
			## show message about too small?
			#return
	#else:
		#return # dont play denied for ranom inputs
	## AudioManager.set_level_select(true) need to set in level select
	#if update:
		#AudioManager.set_size(level.CurrentState().player.size)
		#level.DEBUG_PrintState(level.CurrentState())
	#else:
		#AudioManager.play_denied()

func LeaveLevel():
	get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")
