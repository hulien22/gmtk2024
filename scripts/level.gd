class_name Level

var rendered_level: RenderedLevel

var starting_state: LevelState
var state_stack: Array[LevelState] = []

var level_num: int = 1
var level_name: String = "Unnamed Level"
var width:int
var height:int

var animation_events: Array[AnimationEvent]

# don't show flag when the stage has been completed once
var completed:bool = false
var dead:bool = false

# 2d array of bool to represent walls / empty spaces
# 1 if there is any wall of any size in that 4x4 square, else 0
var walls_b: Array[Array] 
# 2d array of bool to represent walls / empty spaces, else 0
# 1 if there is any wall of any size in that 2x2 square
var walls_m: Array[Array]
var walls_s: Array[Array] # 2d array of bool to represent walls / empty spaces

signal player_moved(size, new_pos)

func CurrentState() -> LevelState:
	return state_stack.back()

func TryMove(dir: Enums.Direction) -> bool:
	if dead:
		return false

	var cur_state: LevelState = CurrentState()
	
	var player_body_obj: PlayerBodyObj = WillPlayerRejoin(dir)
	if player_body_obj != null:
		var new_state: LevelState = cur_state.custom_duplicate()
		
		var smallplayer_anim: AnimationEvent = AnimationEvent.new()
		smallplayer_anim.anim_type = AnimationEvent.AnimationType.RETURNED
		smallplayer_anim.obj_type = TileObj.TileType.PLAYER
		smallplayer_anim.posn = new_state.player.posn
		smallplayer_anim.new_posn = player_body_obj.posn
		animation_events.push_back(smallplayer_anim)
		
		# delete body
		for obj in new_state.collision_objects:
			if obj.type == player_body_obj.type && obj.posn == player_body_obj.posn:
				new_state.collision_objects.erase(obj)
				break
		# update player
		new_state.player.posn = player_body_obj.posn
		new_state.player.size = player_body_obj.size
		new_state.player.direction = player_body_obj.direction
		
		var bigplayer_anim: AnimationEvent = AnimationEvent.new()
		bigplayer_anim.anim_type = AnimationEvent.AnimationType.REVIVE
		bigplayer_anim.obj_type = TileObj.TileType.PLAYER
		bigplayer_anim.posn = new_state.player.posn
		bigplayer_anim.direction = new_state.player.direction
		animation_events.push_back(bigplayer_anim)
		
		UpdateState(new_state)
		return true
	
	if !CanPlayerMove(dir):
		if dir != cur_state.player.direction:
			# Can't move, but can change directions
			var new_state: LevelState = cur_state.custom_duplicate()
			new_state.player.direction = dir
			
			var anim_event: AnimationEvent = AnimationEvent.new()
			anim_event.anim_type = AnimationEvent.AnimationType.MOVED
			anim_event.obj_type = TileObj.TileType.PLAYER
			anim_event.posn = new_state.player.posn
			anim_event.new_posn = new_state.player.posn
			anim_event.direction = new_state.player.direction
			animation_events.push_back(anim_event)
			
			UpdateState(new_state)
			return true
		return false
	
	var new_state: LevelState = cur_state.custom_duplicate()
	var moved_obj: TileObj = GetMovedObj(new_state, dir)
	var crushed_objs: Array[TileObj] = GetCrushedObjs(new_state, dir, moved_obj)
	
	# update player and moved_objs positions
	var movement_vec: Vector2i = Enums.GetDirection(dir) * new_state.player.size
	
	var player_anim: AnimationEvent = AnimationEvent.new()
	player_anim.anim_type = AnimationEvent.AnimationType.MOVED
	player_anim.obj_type = TileObj.TileType.PLAYER
	player_anim.posn = new_state.player.posn
	player_anim.new_posn = new_state.player.posn + movement_vec
	player_anim.direction = dir
	animation_events.push_back(player_anim)
	new_state.player.posn = new_state.player.posn + movement_vec
	new_state.player.direction = dir

	if moved_obj != null:
		var anim_event: AnimationEvent = AnimationEvent.new()
		anim_event.anim_type = AnimationEvent.AnimationType.MOVED
		anim_event.obj_type = moved_obj.type
		anim_event.posn = moved_obj.posn
		anim_event.new_posn = moved_obj.posn + movement_vec
		animation_events.push_back(anim_event)
		
		moved_obj.posn = moved_obj.posn + movement_vec
	for obj in crushed_objs:
		CrushBox(obj, new_state)
	
	# TODO check if we are on any buttons and activate if not activated before
	
	UpdateState(new_state)
	return true

func TrySummon() -> bool:
	if dead:
		return false

	var state: LevelState = CurrentState()
	if state.player.size == TileObj.TileSize.SMALL:
		# already too small
		return false
	
	var new_posn = GetSummonPosn()
	print(new_posn)
	if new_posn == Vector2i(-1,-1):
		# TODO emit signal to display "NO ROOM" message
		return false
	
	# summon new guy!
	var new_state: LevelState = state.custom_duplicate()
	
	# turn current body into corpse
	var body_obj:TileObj = PlayerBodyObj.new()
	body_obj.CopyFromPlayer(state.player)
	new_state.collision_objects.push_back(body_obj)
	# replace player now
	new_state.player.size = new_state.player.size / 2
	new_state.player.posn = new_posn
	
	var smallplayer_anim: AnimationEvent = AnimationEvent.new()
	smallplayer_anim.anim_type = AnimationEvent.AnimationType.SPAWNED
	smallplayer_anim.obj_type = TileObj.TileType.PLAYER
	smallplayer_anim.posn = body_obj.posn
	smallplayer_anim.new_posn = new_state.player.posn
	smallplayer_anim.direction = new_state.player.direction
	smallplayer_anim.size = new_state.player.size
	animation_events.push_back(smallplayer_anim)
	
	var bigplayer_anim: AnimationEvent = AnimationEvent.new()
	bigplayer_anim.anim_type = AnimationEvent.AnimationType.DEACTIVATED
	bigplayer_anim.obj_type = TileObj.TileType.PLAYER
	bigplayer_anim.posn = body_obj.posn
	bigplayer_anim.new_posn = body_obj.posn
	animation_events.push_back(bigplayer_anim)
	
	UpdateState(new_state)
	return true

func TryToggleSwitch() -> bool:
	if dead:
		return false

	var state: LevelState = CurrentState()
	var new_state: LevelState = state.custom_duplicate()
	# see if we are on a switch of our size
	var updated:bool = false
	for obj in new_state.bg_objects:
		if obj.type == TileObj.TileType.SWITCH && obj.size == new_state.player.size && \
		   obj.CollidesWith(new_state.player.posn, new_state.player.size):
			obj.activated = !obj.activated
			updated = true
			
			var anim_event: AnimationEvent = AnimationEvent.new()
			if obj.activated:
				anim_event.anim_type = AnimationEvent.AnimationType.ACTIVATED
			else:
				anim_event.anim_type = AnimationEvent.AnimationType.DEACTIVATED
			anim_event.obj_type = obj.type
			anim_event.posn = obj.posn
			animation_events.push_back(anim_event)
			
			break
	
	if !updated:
		return false
	
	UpdateState(new_state)
	return true

func Undo() -> bool:
	if state_stack.size() <= 1:
		return false
	state_stack.pop_back()
	dead = false
	# don't update any colors, previous state should already have sorted that out
	rendered_level.init(self)
	return true

func Reset() -> bool:
	state_stack.clear()
	state_stack.push_back(starting_state)
	dead = false
	# don't update completed, that stays
	rendered_level.init(self)
	return true

func UpdateState(new_state: LevelState):
	# also need to update colors
	ComputeLevelColorState(new_state)
	while HandleLevelColorState(new_state):
		 # crushed a box, recompute as may no longer be on a button
		# TODO stagger PlayAnims ?? kinda weird with the crushed boxes and buttons..
		# one thought, have a secondary animation_events, crushed boxes in HandleLevelColorState go there
		# then we play anim here, and swap in secondary animation_events
		PlayAnim()
		ComputeLevelColorState(new_state)
	
	#PlayAnim(new_state.player.size, new_state.player.posn)
	PlayAnim()
	state_stack.push_back(new_state)

func ComputeLevelColorState(new_state: LevelState):
	new_state.level_color_states = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	for obj in new_state.bg_objects:
		if obj.type == TileObj.TileType.SWITCH:
			if obj.activated:
				new_state.level_color_states[obj.color] = !new_state.level_color_states[obj.color]
		elif obj.type == TileObj.TileType.BUTTON:
			# check if we have an object on us - obj also needs to be our size or larger
			var button_is_activated = false
			for top_obj in new_state.collision_objects:
				if top_obj.size >= obj.size && top_obj.CollidesWith(obj.posn, obj.size):
					button_is_activated = true
					break
			if !button_is_activated && new_state.player.size >= obj.size && new_state.player.CollidesWith(obj.posn, obj.size):
				button_is_activated = true
			if button_is_activated:
				new_state.level_color_states[obj.color] = !new_state.level_color_states[obj.color]
				obj.activated = true
			obj.activated = false
			
			var anim_event: AnimationEvent = AnimationEvent.new()
			if button_is_activated:
				anim_event.anim_type = AnimationEvent.AnimationType.ACTIVATED
			else:
				anim_event.anim_type = AnimationEvent.AnimationType.DEACTIVATED
			anim_event.obj_type = obj.type
			anim_event.posn = obj.posn
			animation_events.push_back(anim_event)


# Returns whether or not we deleted stuff - requires a recompute of colors
func HandleLevelColorState(new_state: LevelState) -> bool:
	#TODO combine with global state
	var combined_color_states = new_state.level_color_states
	var crushed_box:bool = false
	
	# Color walls swap between collision_objects and bg_objects depending on if they are activated or not
	var deactivated_walls: Array[TileObj] = []
	var activated_walls: Array[TileObj] = []
	for obj in new_state.collision_objects:
		if obj.type == TileObj.TileType.COLOR_WALL:
			if obj.is_reversed:
				obj.activated = !combined_color_states[obj.color]
			else:
				obj.activated = combined_color_states[obj.color]
			
			if !obj.activated:
				# need to move to bg_objects
				deactivated_walls.push_back(obj)
	
	for obj in new_state.bg_objects:
		if obj.type == TileObj.TileType.COLOR_WALL:
			if obj.is_reversed:
				obj.activated = !combined_color_states[obj.color]
			else:
				obj.activated = combined_color_states[obj.color]
			
			if obj.activated:
				# need to move to collision_objects
				activated_walls.push_back(obj)
				# check if anything collides with us, need to crush it
				for col_obj in new_state.collision_objects:
					if col_obj.CollidesWith(obj.posn, obj.size):
						if col_obj.type == TileObj.TileType.PLAYER_BODY:
							# DEATH
							print("YOU DIED")
							dead = true
						elif col_obj.type == TileObj.TileType.BOX:
							# crush the box 
							CrushBox(col_obj, new_state)
							crushed_box = true
				if new_state.player.CollidesWith(obj.posn, obj.size):
					print("YOU DIED")
					dead = true
	
	for wall in deactivated_walls:
		new_state.bg_objects.push_back(wall)
		new_state.collision_objects.erase(wall)
		
		var anim_event: AnimationEvent = AnimationEvent.new()
		anim_event.anim_type = AnimationEvent.AnimationType.DEACTIVATED
		anim_event.obj_type = wall.type
		anim_event.posn = wall.posn
		animation_events.push_back(anim_event)
	for wall in activated_walls:
		new_state.collision_objects.push_back(wall)
		new_state.bg_objects.erase(wall)
		
		var anim_event: AnimationEvent = AnimationEvent.new()
		anim_event.anim_type = AnimationEvent.AnimationType.ACTIVATED
		anim_event.obj_type = wall.type
		anim_event.posn = wall.posn
		animation_events.push_back(anim_event)
	
	return crushed_box

func WillPlayerRejoin(dir: Enums.Direction) -> PlayerBodyObj:
	var state: LevelState = CurrentState()
	if (state.player.size == TileObj.TileSize.BIG):
		return null
	var target_posn:Vector2i = state.player.posn + Enums.GetDirection(dir) * state.player.size
	for obj in state.collision_objects:
		if obj.type == TileObj.TileType.PLAYER_BODY && obj.size == state.player.size * 2 && obj.CollidesWith(target_posn, state.player.size):
			return obj
	return null

func CanPlayerMove(dir: Enums.Direction) -> bool:
	var state: LevelState = CurrentState()
	var target_posn:Vector2i = state.player.posn + Enums.GetDirection(dir) * state.player.size
	return CanObjMoveTo(state, target_posn, state.player.size, dir, TileObj.TileType.PLAYER)

func CanObjMoveTo(state: LevelState, target_posn:Vector2i, size: TileObj.TileSize, dir: Enums.Direction, type: TileObj.TileType) -> bool:
	if (!IsPosnInBounds(target_posn)):
		print("not IsPosnInBounds")
		return false
	if (WallExistsAtPosn(target_posn, size)):
		print("WallExistsAtPosn")
		return false
	
	# now check for other objects
	for obj in state.collision_objects:
		if obj.CollidesWith(target_posn, size):
			if (type == TileObj.TileType.PLAYER):
				if !obj.is_pushable || obj.size > size:
					 # can't move things that aren't pushable, bigger things than us
					print("!!", obj)
					return false
				if obj.size < size:
					# we can move into this spot and will crush it
					# need to check for other objects that might not be pushable
					continue
				assert(obj.size == size)
				# Pushing something of our size
				# check that there's nothing else in the next space up
				var target_posn2:Vector2i = target_posn + Enums.GetDirection(dir) * size
				return CanObjMoveTo(state, target_posn2, size, dir, obj.type)
			elif (type == TileObj.TileType.BOX):
				if !obj.is_pushable || obj.size >= size:
					# can't push box into non-pushable things, or into bigger/same sized objects
					return false
				# We can push the box into smaller things (crushes them)
				return true
			# TODO handler other types if needed here
	
	### TODO Can't push a box onto a switch?
	#if (type == TileObj.TileType.BOX):
		#for obj in state.bg_objects:
			#if obj.type == TileObj.TileType.SWITCH && obj.CollidesWith(target_posn, size):
				#return false

	print("ret true")
	return true

# Assumes that CanPlayerMove == true
func GetMovedObj(state: LevelState, dir: Enums.Direction) -> TileObj:
	var target_posn:Vector2i = state.player.posn + Enums.GetDirection(dir) * state.player.size
	for obj in state.collision_objects:
		if obj.CollidesWith(target_posn, state.player.size) && obj.size == state.player.size:
			return obj
	return null

func GetCrushedObjs(state: LevelState, dir: Enums.Direction, moved_obj: TileObj) -> Array[TileObj]:
	var target_posn:Vector2i = state.player.posn + Enums.GetDirection(dir) * state.player.size
	var crushed_objs: Array[TileObj] = []
	for obj in state.collision_objects:
		if obj.CollidesWith(target_posn, state.player.size) && obj.size < state.player.size:
			crushed_objs.push_back(obj)
	if (moved_obj != null):
		target_posn = moved_obj.posn + Enums.GetDirection(dir) * state.player.size
		for obj in state.collision_objects:
			if obj.CollidesWith(target_posn, state.player.size) && obj.size < state.player.size:
				crushed_objs.push_back(obj)
	return crushed_objs

func IsPosnInBounds(posn: Vector2i) -> bool:
	return posn.x >= 0 && posn.x < width && posn.y >= 0 && posn.y < height

func WallExistsAtPosn(posn: Vector2i, size: TileObj.TileSize) -> bool:
	match size:
		TileObj.TileSize.BIG:
			return walls_b[posn.y / 4][posn.x / 4]
		TileObj.TileSize.MEDIUM:
			return walls_m[posn.y / 2][posn.x / 2]
		_:
			return walls_s[posn.y][posn.x]

func IsSummonPosnAvailable(target_posn: Vector2i, size: TileObj.TileSize) -> bool:
	var state: LevelState = CurrentState()
	if (!IsPosnInBounds(target_posn)):
		return false
	if (WallExistsAtPosn(target_posn, size)):
		return false
	
	for obj in state.collision_objects:
		if obj.CollidesWith(target_posn, size):
			return false
	# for boxes, also check if there are switches here, can't push onto those
	
	return true

func GetSummonPosn() -> Vector2i:
	# first check 1 then check 2
	#    12
	#   2PP1
	#   1PP2
	#    21
	var state: LevelState = CurrentState()
	var size:int = state.player.size
	var new_size:int = size / 2
	var dir:Enums.Direction = state.player.direction
	var target_posn:Vector2i = state.player.posn
	match dir:
		Enums.Direction.UP:
			target_posn = state.player.posn + Enums.GetDirection(Enums.Direction.UP) * new_size
		Enums.Direction.RIGHT:
			target_posn = state.player.posn + Enums.GetDirection(Enums.Direction.RIGHT) * size
		Enums.Direction.DOWN:
			target_posn = state.player.posn + Enums.GetDirection(Enums.Direction.DOWN) * size + Enums.GetDirection(Enums.Direction.RIGHT) * new_size
		Enums.Direction.LEFT:
			target_posn = state.player.posn + Enums.GetDirection(Enums.Direction.LEFT) * new_size + Enums.GetDirection(Enums.Direction.DOWN) * new_size
	
	if IsSummonPosnAvailable(target_posn, new_size):
		return target_posn
	
	# try posn 2
	match dir:
		Enums.Direction.UP:
			target_posn = state.player.posn + Enums.GetDirection(Enums.Direction.UP) * new_size + Enums.GetDirection(Enums.Direction.RIGHT) * new_size
		Enums.Direction.RIGHT:
			target_posn = state.player.posn + Enums.GetDirection(Enums.Direction.RIGHT) * size + Enums.GetDirection(Enums.Direction.DOWN) * new_size
		Enums.Direction.DOWN:
			target_posn = state.player.posn + Enums.GetDirection(Enums.Direction.DOWN) * size
		Enums.Direction.LEFT:
			target_posn = state.player.posn + Enums.GetDirection(Enums.Direction.LEFT) * new_size
	
	if IsSummonPosnAvailable(target_posn, new_size):
		return target_posn
	
	# return nope
	return Vector2i(-1,-1)

func CrushBox(obj: TileObj, new_state: LevelState):
	assert(obj.type == TileObj.TileType.BOX)
	
	var anim_event: AnimationEvent = AnimationEvent.new()
	anim_event.anim_type = AnimationEvent.AnimationType.CRUSHED
	anim_event.obj_type = obj.type
	anim_event.posn = obj.posn
	animation_events.push_back(anim_event)
	
	# Add crushed object tile (to show debris)
	var new_obj:TileObj = CrushedBoxObj.new()
	new_obj.posn = obj.posn
	new_obj.size = obj.size
	new_obj.AssertOnGrid()
	new_state.bg_objects.push_back(new_obj)
	new_state.collision_objects.erase(obj)

func PlayAnim():
	#player_moved.emit(size, new_pos)
	rendered_level.ProcessAnimationEvents(animation_events)
	animation_events.clear()

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
			return Enums.Colors.LIGHTGREEN
		"G":
			return Enums.Colors.DARKGREEN
		"B":
			return Enums.Colors.DARKBLUE
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
					starting_state.player.posn = Vector2i(j,i)
					starting_state.player.AssertOnGrid()
				"F":
					var new_obj:TileObj = FlagObj.new()
					new_obj.posn = Vector2i(j,i)
					new_obj.size = GetSizeFromChar(text[1])
					assert(text[2] == " ")
					new_obj.AssertOnGrid()
					starting_state.bg_objects.push_back(new_obj)
				"X":
					var new_obj:TileObj = BoxObj.new()
					new_obj.posn = Vector2i(j,i)
					new_obj.size = GetSizeFromChar(text[1])
					assert(text[2] == " ")
					new_obj.AssertOnGrid()
					starting_state.collision_objects.push_back(new_obj)
				"C":
					var new_obj:TileObj = ColoredWallObj.new()
					new_obj.posn = Vector2i(j,i)
					new_obj.color = GetColorFromChar(text[1])
					new_obj.AssertOnGrid()
					if text[2] == "R":
						new_obj.is_reversed = true
						new_obj.activated = true
						starting_state.collision_objects.push_back(new_obj)
					else:
						assert(text[2] == " ")
						new_obj.activated = false
						starting_state.bg_objects.push_back(new_obj)
				"S":
					var new_obj:TileObj = SwitchObj.new()
					new_obj.posn = Vector2i(j,i)
					new_obj.color = GetColorFromChar(text[1])
					new_obj.size = GetSizeFromChar(text[2])
					new_obj.AssertOnGrid()
					starting_state.bg_objects.push_back(new_obj)
				"B":
					var new_obj:TileObj = ButtonObj.new()
					new_obj.posn = Vector2i(j,i)
					new_obj.color = GetColorFromChar(text[1])
					new_obj.size = GetSizeFromChar(text[2])
					new_obj.AssertOnGrid()
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
			if tile.activated:
				return "S" + str(tile.color) + " "
			return "s" + str(tile.color) + " "
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
			if !tile.activated:
				return "-" + str(tile.color) + "-"
			return "C" + str(tile.color) + " "
		TileObj.TileType.CRUSHED_BOX:
			return "x  "
	return "?? "

func DEBUG_WhatIsAtPoint(state: LevelState, posn: Vector2i) -> String:
	if walls_s[posn.y][posn.x]:
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
			var posn: Vector2i = Vector2i(j, i)
			out += DEBUG_WhatIsAtPoint(state, posn)
		print(out)
	print()
