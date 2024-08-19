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
#var levelstr: Array[String] = [
#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  SRB.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  .  .  .  .  .  .  BGM.  .  .  .  .  XM .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#"PB .  .  .  XM .  BRM.  CRR.  BRM.  .  .  SRM.  .  .  .  .  w  w  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  .  .  .  .  CRR.  .  .  .  .  .  .  .  .  .  .  w  w  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  XB .  .  .  CG BGS.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  XS XS XS XS .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
#]

##### LEVEL: SCALING A MOUNTAIN
var levelstr: Array[String] = [
	"w  w  w  w  w  w  w  w  w  w  w  w  .  FS w  w  ",
	"w  w  w  w  w  w  w  w  w  .  w  w  CRRw  w  w  ",
	"w  w  w  w  w  w  w  BRSXS XS .  .  XS w  w  w  ",
	"w  w  w  w  w  w  w  w  w  .  w  w  .  w  w  w  ",
	"w  w  w  w  w  w  w  w  w  .  w  w  .  w  w  w  ",
	"w  w  w  w  w  w  w  w  w  CR w  w  CRRw  w  w  ",
	"w  w  w  w  w  w  .  .  XM .  BRM.  .  .  BRM.  ",
	"w  w  w  w  w  w  .  .  .  .  .  .  .  .  .  .  ",
	"w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  CRRCRRw  w  w  w  w  w  w  w  ",
	"PB .  .  .  XB .  .  .  .  .  .  .  BRB.  .  .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
]

####### LEVEL: TRAPPED
#var levelstr: Array[String] = [
	#"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	#"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	#"w  w  w  w  w  w  w  w  FS w  w  w  w  w  w  w  w  w  w  w  ",
	#"w  w  w  w  w  w  w  w  CR w  w  w  w  w  w  w  w  w  w  w  ",
	#"BRM.  CR CR BRB.  .  .  PB .  .  .  .  .  .  .  CR CR .  .  ",
	#".  .  CR CR .  .  .  .  .  .  .  .  .  .  .  .  CR CR .  .  ",
	#"BRM.  CR CR .  .  .  .  .  .  .  .  BRM.  .  .  CR CR .  .  ",
	#".  .  CR CR .  .  .  .  .  .  .  .  .  .  .  .  CR CR .  .  ",
	#".  .  w  w  w  w  w  w  w  w  w  w  CR CR w  w  w  w  .  .  ",
	#".  .  w  w  w  w  w  w  w  w  w  w  CR CR w  w  w  w  .  .  ",
	#"XM .  XM .  .  .  .  .  .  .  .  .  BRM.  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
	#"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	#"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
#]

#######  LEVEL: THE DELETE KEY
#var levelstr: Array[String] = [
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	#".  .  .  .  XS .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	#"PB .  .  .  XB .  .  .  .  .  .  .  XB .  .  .  .  .  .  .  .  CRR.  .  .  .  .  .  .  .  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CRR.  .  .  .  .  .  .  .  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CRR.  .  XM .  .  .  .  BRSBRS.  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CRR.  .  .  .  .  .  .  .  .  .  ",
	#".  .  .  .  BRB.  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  CR CR CR CR w  w  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  w  w  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  w  w  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  w  w  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  FB .  .  .  w  w  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  w  w  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  w  w  w  w  ",
	#".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  w  w  w  w  ",
#]

#######  LOCKPICKING LEVEL
# var levelstr: Array[String] = [
# 	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	".  .  .  .  BGB.  .  .  .  .  .  .  w  w  w  w  w  w  .  .  .  .  XM .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	"PB .  .  .  XB .  .  .  w  w  w  w  w  w  .  .  .  .  .  .  XM .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  w  w  w  w  w  w  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CGRCY .  .  .  .  CYRCG .  .  .  .  CGRCYR.  .  .  .  CYRCG .  .  .  .  CGRCY .  FM .  ",
# 	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CGRCY .  .  .  .  CYRCG .  .  .  .  CGRCYR.  .  .  .  CYRCG .  .  .  .  CGRCY .  .  .  ",
# 	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
# 	".  .  w  w  BYB.  .  .  .  .  .  .  w  w  .  .  .  .  .  .  .  .  XM .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
# 	".  .  w  w  .  .  .  .  .  .  .  .  w  w  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
# 	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
# 	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  XM .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  ",
# 	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  ",
# 	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
# 	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
# ]

#var levelstr: Array[String] = [
	#".  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  FM .  ",
	#"w  w  w  w  .  .  .  .  ",
	#"PB .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  ",
	#".  .  .  .  .  .  .  .  ",
#]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = Level.new()
	level.LoadLevelFromText(levelstr)
	level.DEBUG_PrintState(level.CurrentState())
	level.rendered_level = $RenderedLevel
	$RenderedLevel.init(level)

func _input(event):
	var update: bool = false
	if event.is_action_pressed("ui_up"):
		update = level.TryMove(Enums.Direction.UP)
	elif event.is_action_pressed("ui_down"):
		update = level.TryMove(Enums.Direction.DOWN)
	elif event.is_action_pressed("ui_right"):
		update = level.TryMove(Enums.Direction.RIGHT)
	elif event.is_action_pressed("ui_left"):
		update = level.TryMove(Enums.Direction.LEFT)
	elif event.is_action_pressed("ui_accept"):
		update = level.TrySummon()
	elif event.is_action_pressed("ToggleSwitch"):
		update = level.TryToggleSwitch()
	elif event.is_action_pressed("Undo"):
		update = level.Undo()
	elif event.is_action_pressed("ResetLevel"):
		update = level.Reset()
	elif event.is_action_pressed("ReturnToLevelSelect"):
		if level.CurrentState().player.size == TileObj.TileSize.BIG:
			get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")
			return
		else:
			# show message about too small?
			return
	else:
		return # dont play denied for ranom inputs
	# AudioManager.set_level_select(true) need to set in level select
	if update:
		AudioManager.set_size(level.CurrentState().player.size)
		level.DEBUG_PrintState(level.CurrentState())
	else:
		AudioManager.play_denied()
