extends Node2D

var level: Level

var levelstr: Array[String] = [
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  PB .  .  .  .  .  .  .  CB .  .  .  FB .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	"SBM.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  CB .  .  .  .  .  .  .  .  .  .  .  ",
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
	if event.is_action_pressed("ui_up"):
		pass
