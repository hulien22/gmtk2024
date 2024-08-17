extends Node2D

var level: Level

var levelstr: Array[String] = [
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  XS .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	".  .  XM .  .  .  .  .  w  w  w  w  .  .  .  .  PB .  .  .  .  .  .  .  CBR.  .  .  FB .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	"SBM.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  XB .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CBR.  .  .  .  .  .  .  .  .  .  .  ",
]
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

func _input(event):
	var update:bool = false
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
	
	if update: 
		level.DEBUG_PrintState(level.CurrentState())
