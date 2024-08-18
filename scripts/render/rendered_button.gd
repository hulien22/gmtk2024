extends Sprite2D

var color: Enums.Colors

func init(obj: ButtonObj):
	color = obj.color
	position = obj.posn
	match obj.size:
		TileObj.TileSize.BIG:
			scale = Vector2(0.02, 0.02)
		TileObj.TileSize.MEDIUM:
			scale = Vector2(0.01, 0.01)
		TileObj.TileSize.SMALL:
			scale = Vector2(0.005, 0.005)
	texture = ArtManager.get_button(!obj.activated, color)
	
func on_toggle(is_pressed: bool):
	texture = ArtManager.get_button(!is_pressed, color)
