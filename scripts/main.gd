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
	
	if WorldState.active_level == 0:
		%Level1.show()
	elif WorldState.active_level == 1:
		%Level2.show()
	elif WorldState.active_level == 8:
		%Level1.show()

func LoadLevel():
	level = WorldState.levels[WorldState.active_level]
	%Camera2D.zoom = Vector2.ONE * WorldState.level_infos[WorldState.active_level].camera_zoom
	%Camera2D.offset = WorldState.level_infos[WorldState.active_level].camera_offset
	%UI.scale = Vector2(1 / %Camera2D.zoom.x,1 / %Camera2D.zoom.y)
	%UI.position = Vector2(%Camera2D.offset.x,%Camera2D.offset.y)
	%BgTiles.position = WorldState.level_infos[WorldState.active_level].bg_tile_posn
	%BgTiles.size = WorldState.level_infos[WorldState.active_level].bg_tile_size
	level.rendered_level = $RenderedLevel
	level.show_message.connect(ShowMessage)
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
	
	if level.dead:
		%YouDied.show()
	else:
		%YouDied.hide()
	
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
				LeaveLevel()
				return
			else:
				# show message about too small?
				pass
				#is_animating = false
				#return
	if update:
		AudioManager.set_size(level.CurrentState().player.size)
		level.DEBUG_PrintState(level.CurrentState())
		
		var wait_time = level.CheckForCompletion()
		if wait_time > 0:
			await get_tree().create_timer(wait_time).timeout
			LeaveLevel()
			return
	else:
		AudioManager.play_denied()
	is_animating = false


func LeaveLevel():
	get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")

func ShowMessage(m:String):
	%Notice/NoticeText.text = m
	%Notice/AnimationPlayer.stop()
	%Notice/AnimationPlayer.play("ErrorMessage")
