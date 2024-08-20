extends LevelInfo

func _init():
	level_str = [
	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  w  w  FS w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  w  w  CM w  w  w  w  w  w  w  w  w  w  w  ",
	"BMM.  CM CM BMB.  .  .  PB .  .  .  .  .  .  .  CM CM .  .  ",
	".  .  CM CM .  .  .  .  .  .  .  .  .  .  .  .  CM CM .  .  ",
	"BMM.  CM CM .  .  .  .  .  .  .  .  BMM.  .  .  CM CM .  .  ",
	".  .  CM CM .  .  .  .  .  .  .  .  .  .  .  .  CM CM .  .  ",
	".  .  w  w  w  w  w  w  w  w  w  w  CM CM w  w  w  w  .  .  ",
	".  .  w  w  w  w  w  w  w  w  w  w  CM CM w  w  w  w  .  .  ",
	"XM .  XM .  .  .  .  .  .  .  .  .  BMM.  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
	".  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ",
	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	"w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  ",
	]
	level_name = "Trapped"
	camera_zoom = 0.17
	camera_offset = Vector2(-1300, -100)
	bg_tile_posn = Vector2(200,200)
	bg_tile_size = Vector2(4200,3000)
