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

func custom_duplicate() -> LevelState:
	var new_state = LevelState.new()
	new_state.player = player.duplicate(true)
	new_state.collision_objects = collision_objects.duplicate(true)
	new_state.bg_objects = bg_objects.duplicate(true)
	return new_state
