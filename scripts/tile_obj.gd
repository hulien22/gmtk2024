class_name TileObj

enum TileType {
	SWITCH,
	BUTTON,
	FLAG,
	PLAYER,
	PLAYER_BODY,
	BOX,
	COLOR_WALL,
}

enum TileSize {
	BIG = 4,       # only mark the top left corner, should be divisible by 4
	MEDIUM = 2,    # only mark the top left corner, should be divisible by 2
	SMALL = 1
}

var posn: Vector2i = Vector2i.ZERO;
var type: TileType;
var size: TileSize = TileSize.SMALL
var color: Enums.Colors = Enums.Colors.NONE
var is_pushable:bool = false
var activated:bool = false;
var direction: Enums.Direction = Enums.Direction.RIGHT

func CollidesWith(other_posn: Vector2i, other_size: TileSize) -> bool:
	# we are all locked to similar grids, so only need to check one point depending on sizes
	if (other_size == size):
		return other_posn == posn
	if (other_size > size):
		return posn.x >= other_posn.x && posn.x < other_posn.x + other_size && \
			   posn.y >= other_posn.y && posn.y < other_posn.y + other_size
	return other_posn.x >= posn.x && other_posn.x < other_posn.x + size && \
		   other_posn.y >= posn.y && other_posn.y < other_posn.y + size
