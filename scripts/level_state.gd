extends Resource
class_name LevelState

# The current active player
var player: PlayerObj

# Boxes, colored walls, player bodies
var collision_objects: Array[TileObj] = []  # Vector2i -> TileObj

# Buttons and Switches and Flag
var bg_objects: Array[TileObj] = [] # Vector2i -> TileObj

# figure out which to use..
func test():
	inst_to_dict(self)
	var_to_bytes(self)
