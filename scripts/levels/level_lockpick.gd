extends LevelInfo

func _init():
	level_str = [
	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  BWB.  .  .  .  .  .  .  w  w  w  w  w  w  .  .  .  .  XM .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"PB .  .  .  XB .  .  .  w  w  w  w  w  w  .  .  .  .  .  .  XM .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  .  .  .  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CWRCP .  .  .  .  CPRCW .  .  .  .  CWRCPR.  .  .  .  CPRCW .  .  .  .  CWRCP .  FM .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  CWRCP .  .  .  .  CPRCW .  .  .  .  CWRCPR.  .  .  .  CPRCW .  .  .  .  CWRCP .  .  .  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	".  .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
	".  .  w  w  BPB.  .  .  .  .  .  .  w  w  .  .  .  .  .  .  .  .  XM .  .  .  .  .  .  .  w  w  w  w  w  w  w  w  w  w  .  .  w  w  w  w  w  w  ",
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
	camera_offset = Vector2(0, -200)
	bg_tile_posn = Vector2(200,200)
	bg_tile_size = Vector2(9800,5000)
