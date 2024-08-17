extends TileObj
class_name ColoredWallObj

var is_reversed: bool = false

func _init():
	type = TileType.COLOR_WALL
	size = TileSize.SMALL
