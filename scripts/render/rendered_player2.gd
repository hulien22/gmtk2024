extends RenderedObj
class_name RenderedPlayer

@export var big_texture: Texture
@export var medium_texture: Texture
@export var small_texture: Texture

func init(obj: TileObj):
	super.init(obj)
	%SpriteHolder.position = obj.posn
	%SpriteHolder.scale = Vector2(0.04, 0.04)
	match obj.size:
		TileObj.TileSize.BIG:
			%Sprite.texture = big_texture
		TileObj.TileSize.MEDIUM:
			%Sprite.texture = medium_texture
		TileObj.TileSize.SMALL:
			%Sprite.texture = small_texture
	
