extends RenderedObj
class_name RenderedButton

func init(obj: TileObj):
	super.init(obj)
	%SpriteHolder.position = obj.posn
	match obj.size:
		TileObj.TileSize.BIG:
			%SpriteHolder.scale = Vector2(0.02, 0.02)
		TileObj.TileSize.MEDIUM:
			%SpriteHolder.scale = Vector2(0.01, 0.01)
		TileObj.TileSize.SMALL:
			%SpriteHolder.scale = Vector2(0.005, 0.005)
	%Sprite.texture = ArtManager.get_button(!obj.activated, color)
