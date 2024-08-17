class_name Level

var starting_state: LevelState
var state_stack: Array[LevelState] = []

var level_num: int = 1
var level_name: String = "Unnamed Level"
var width:int
var height:int
# don't show flag when the stage has been completed once
var completed:bool = false

# 2d array of bool to represent walls / empty spaces
# 1 if there is any wall of any size in that 4x4 square, else 0
var walls_b: Array[Array] 
# 2d array of bool to represent walls / empty spaces, else 0
# 1 if there is any wall of any size in that 2x2 square
var walls_m: Array[Array]
var walls_s: Array[Array] # 2d array of bool to represent walls / empty spaces

func LoadLevel():
	pass

func CurrentState() -> LevelState:
	return state_stack.back()

func TryMove(dir: Enums.Direction):
	var cur_state: LevelState = CurrentState()
	if !CanPlayerMove(dir):
		if dir != cur_state.player.direction:
			# Can't move, but can change directions
			var new_state: LevelState = cur_state.duplicate()
			new_state.player.direction = dir
			state_stack.push_back(new_state)
			PlayAnim()
		return
	
	var new_state: LevelState = cur_state.duplicate()
	var moved_objs: Array[TileObj] = GetMovedObjs(dir)
	
	# check if we are on any buttons and activate if not activated before
	
	# update player and moved_objs positions
	
	PlayAnim()
	state_stack.push_back(new_state)
	

func CanPlayerMove(dir: Enums.Direction) -> bool:
	var state: LevelState = CurrentState()
	var target_posn:Vector2i = state.player.posn + Enums.GetDirection(dir) * state.player.size
	return IsPosnMoveable(state, target_posn, state.player.size, dir, true)

func IsPosnMoveable(state: LevelState, target_posn:Vector2i, size: TileObj.TileSize, dir: Enums.Direction, allow_recurse:bool) -> bool:
	if (!IsPosnInBounds(target_posn)):
		return false
	if (!WallExistsAtPosn(target_posn, state.player.size)):
		return false
	
	# now check for other objects
	for obj in state.collision_objects:
		if obj.CollidesWith(target_posn, state.player.size):
			if !obj.is_pushable || obj.size > state.player.size || !allow_recurse:
				 # can't move things that aren't pushable, bigger things than us, or if we're already trying to push smth
				return false
			else:
				# check that there's nothing else in the next space up
				var target_posn2:Vector2i = target_posn + Enums.GetDirection(dir) * size
				
				# TODO can just return this if we don't allow pushing multiple smaller things
				if !IsPosnMoveable(state, target_posn2, size, dir, false):
					return false
	return true

# Assumes that CanPlayerMove == true
func GetMovedObjs(dir: Enums.Direction) -> Array[TileObj]:
	var state: LevelState = CurrentState()
	var target_posn:Vector2i = state.player.posn + Enums.GetDirection(dir) * state.player.size
	var moved_objs: Array[TileObj] = []
	for obj in state.collision_objects:
		if obj.CollidesWith(target_posn, state.player.size):
			moved_objs.push_back(obj)
	return moved_objs

func IsPosnInBounds(posn: Vector2i) -> bool:
	return posn.x >= 0 && posn.x < width && posn.y >= 0 && posn.y < height

func WallExistsAtPosn(posn: Vector2i, size: TileObj.TileSize) -> bool:
	match size:
		TileObj.TileSize.BIG:
			return walls_b[posn.y / 4][posn.x / 4]
		TileObj.TileSize.MEDIUM:
			return walls_b[posn.y / 2][posn.x / 2]
		_:
			return walls_b[posn.y][posn.x]

func PlayAnim():
	pass
