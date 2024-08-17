extends TileObj
class_name PlayerBodyObj

func _init():
	type = TileType.PLAYER_BODY

func CopyFromPlayer(p: PlayerObj):
	posn = p.posn
	direction = p.direction
	size = p.size
