extends Resource
class_name LevelState

# The current active player
var player: PlayerObj

# Boxes, colored walls, player bodies
var collision_objects: Array[TileObj] = []  # Vector2i -> TileObj

# Buttons and Switches and Flag
var bg_objects: Array[TileObj] = [] # Vector2i -> TileObj

var level_color_states:Array[bool] = [0, 0, 0, 0, 0, 0];

# figure out which to use..
func test():
	inst_to_dict(self)
	var_to_bytes(self)

func custom_duplicate() -> LevelState:
	var new_state = LevelState.new()
	new_state.player = player.duplicate(true)
	for o in collision_objects:
		new_state.collision_objects.push_back(o.duplicate(true))
	for o in bg_objects:
		new_state.bg_objects.push_back(o.duplicate(true))
	new_state.level_color_states = level_color_states.duplicate(true)
	return new_state
