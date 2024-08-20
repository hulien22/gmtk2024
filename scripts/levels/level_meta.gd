extends LevelInfo

func _init():
	level_str = [
	"PB .  .  .  CPRCPRCPRCPRw  w  w  w  w  w  BGSFS ",
	".  .  .  .  CPRCPRCPRCPRw  w  w  w  w  w  XS BPS",
	".  .  .  .  CPRCPRCPRCPR.  .  CORCORw  w  .  XS ",
	".  .  .  .  CPRCPRCPRCPR.  .  CORCOR.  CGRXS BOS",
	]
	level_name = "Meta"
	camera_zoom = 0.25
	camera_offset = Vector2(0, -800)
	bg_tile_posn = Vector2(200,200)
	bg_tile_size = Vector2(7400,2500)
