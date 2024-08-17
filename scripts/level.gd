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

func CurrentState() -> LevelState:
	return state_stack.back()

func TryMove(dir: Enums.Direction):
	var cur_state: LevelState = CurrentState()
	if !CanPlayerMove(dir):
		if dir != cur_state.player.direction:
			# Can't move, but can change directions
			var new_state: LevelState = cur_state.duplicate(true)
			new_state.player.direction = dir
			state_stack.push_back(new_state)
			PlayAnim()
		return
	
	var new_state: LevelState = cur_state.duplicate(true)
	var moved_objs: Array[TileObj] = GetMovedObjs(new_state, dir)
	
	# check if we are on any buttons and activate if not activated before
	
	# update player and moved_objs positions
	var movement_vec: Vector2i = Enums.GetDirection(dir) * new_state.player.size
	new_state.player.posn = new_state.player.posn + movement_vec
	for mo in moved_objs:
		mo.posn = mo.posn + movement_vec
	
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
	# Can't push a box onto a switch?
	if !allow_recurse:
		for obj in state.bg_objects:
			if obj.type == TileObj.TileType.SWITCH && obj.CollidesWith(target_posn, state.player.size):
				return false
			
	return true

# Assumes that CanPlayerMove == true
func GetMovedObjs(state: LevelState, dir: Enums.Direction) -> Array[TileObj]:
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

static func GetSizeFromChar(c: String) -> TileObj.TileSize:
	match c:
		"B":
			return TileObj.TileSize.BIG
		"M":
			return TileObj.TileSize.MEDIUM
		"S":
			return TileObj.TileSize.SMALL
		_:
			printerr("found unknown size " + c)
			assert(false)
			return TileObj.TileSize.SMALL

static func GetColorFromChar(c: String) -> Enums.Colors:
	match c:
		"R":
			return Enums.Colors.RED
		"O":
			return Enums.Colors.ORANGE
		"Y":
			return Enums.Colors.YELLOW
		"G":
			return Enums.Colors.GREEN
		"B":
			return Enums.Colors.BLUE
		"P":
			return Enums.Colors.PURPLE
		_:
			printerr("found unknown color " + c)
			assert(false)
			return Enums.Colors.NONE

func LoadLevelFromText(map: Array[String]):
	height = map.size()
	width = map[0].length() / 3
	
	assert(height % 4 == 0)
	assert(width % 4 == 0)
	
	starting_state = LevelState.new()
	
	walls_s.clear()
	for i in height:
		walls_s.push_back([])
		for j in width:
			var text = map[i].substr(j*3, 3)
			match text[0]:
				".":
					assert(text == ".  ")
					#walls_s[i].push_back(false)
				"w":
					assert(text == "w  ")
					walls_s[i].push_back(true)
					continue
				"P":
					assert(text == "PB ")
					starting_state.player = PlayerObj.new()
					starting_state.player.posn = Vector2i(i,j)
				"F":
					var new_obj:TileObj = FlagObj.new()
					new_obj.size = GetSizeFromChar(text[1])
					assert(text[2] == " ")
					starting_state.bg_objects.push_back(new_obj)
				"X":
					var new_obj:TileObj = BoxObj.new()
					new_obj.size = GetSizeFromChar(text[1])
					assert(text[2] == " ")
					starting_state.bg_objects.push_back(new_obj)
				"C":
					var new_obj:TileObj = ColoredWallObj.new()
					new_obj.color = GetColorFromChar(text[1])
					if text[2] == "R":
						new_obj.is_reversed = true
					else:
						assert(text[2] == " ")
					starting_state.collision_objects.push_back(new_obj)
				"S":
					var new_obj:TileObj = SwitchObj.new()
					new_obj.color = GetColorFromChar(text[1])
					new_obj.size = GetSizeFromChar(text[2])
					starting_state.bg_objects.push_back(new_obj)
				"B":
					var new_obj:TileObj = ButtonObj.new()
					new_obj.color = GetColorFromChar(text[1])
					new_obj.size = GetSizeFromChar(text[2])
					starting_state.bg_objects.push_back(new_obj)
			walls_s[i].push_back(false)
	
	# sort out walls now
	walls_m.clear()
	for i in height / 2:
		walls_m.push_back([])
		for j in width / 2:
			walls_m[i].push_back(false)
	walls_b.clear()
	for i in height / 4:
		walls_b.push_back([])
		for j in width / 4:
			walls_b[i].push_back(false)
	
	for i in height:
		for j in width:
			if (walls_s[i][j]):
				walls_m[i/2][j/2] = true
				walls_b[i/4][j/4] = true
	
	state_stack.push_back(starting_state)


func DEBUG_TileToString(tile: TileObj) -> String:
	match tile.type:
		TileObj.TileType.SWITCH:
			return "S" + str(tile.color) + " "
		TileObj.TileType.BUTTON:
			return "B" + str(tile.color) + " "
		TileObj.TileType.FLAG:
			return "FF "
		TileObj.TileType.PLAYER:
			return "PP "
		TileObj.TileType.PLAYER_BODY:
			return "pp "
		TileObj.TileType.BOX:
			return "XX "
		TileObj.TileType.COLOR_WALL:
			return "C" + str(tile.color) + " "
	return "?? "

func DEBUG_WhatIsAtPoint(state: LevelState, posn: Vector2i) -> String:
	if walls_s[posn.x][posn.y]:
		return "WW "
	if state.player.CollidesWith(posn,1):
		return DEBUG_TileToString(state.player)
	for o in state.collision_objects:
		if o.CollidesWith(posn, 1):
			return DEBUG_TileToString(o)
	for o in state.bg_objects:
		if o.CollidesWith(posn, 1):
			return DEBUG_TileToString(o)
	return ".. "

func DEBUG_PrintState(state: LevelState):
	for i in height:
		var out: String = ""
		for j in width:
			var posn: Vector2i = Vector2i(i, j)
			out += DEBUG_WhatIsAtPoint(state, posn)
		print(out)
