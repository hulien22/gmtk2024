extends LevelInfo

func _init():
	level_str = [
	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  BGB.  .  .  .  .  .  .  w  w  w  w  w  w  .  .  .  .  XM .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"PB .  .  .  XB .  .  .  w  w  w  w  w  w  .  .  .  .  .  .  XM .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CGRCY .  .  .  .  CYRCG .  .  .  .  CGRCYR.  .  .  .  CYRCG .  .  .  .  CGRCY .  FM .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CGRCY .  .  .  .  CYRCG .  .  .  .  CGRCYR.  .  .  .  CYRCG .  .  .  .  CGRCY .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	".  .  w  w  BYB.  .  .  .  .  .  .  w  w  .  .  .  .  .  .  .  .  XM .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	".  .  w  w  .  .  .  .  .  .  .  .  w  w  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  XM .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	]
	level_name = "Lockpick"
	camera_zoom = 0.115
