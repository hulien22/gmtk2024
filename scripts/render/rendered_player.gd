extends Sprite2D

var cur_pos: Vector2i
var size: TileObj.TileSize

func init(level: Level, init_size: TileObj.TileSize):
	size = init_size
	set_pos(level.CurrentState().player.posn)
	level.player_moved.connect(on_moved)
	if size != TileObj.TileSize.BIG:
		visible = false
	
func set_pos(pos):
	cur_pos = pos
	position = cur_pos
	
func on_moved(moved_size: TileObj.TileSize, new_pos: Vector2i):
	if moved_size != size:
		return
	set_pos(new_pos)

func on_swallow():
	pass

func on_spit():
	pass
