extends RenderedObj
class_name RenderedBox

@export var texture: Texture
@export var crushed_texture: Texture

func init(obj: TileObj):
	super.init(obj)
	%SpriteHolder.position = obj.posn
	set_texture()
	match obj.size:
		TileObj.TileSize.BIG:
			%SpriteHolder.scale = Vector2(0.02, 0.02)
		TileObj.TileSize.MEDIUM:
			%SpriteHolder.scale = Vector2(0.01, 0.01)
		TileObj.TileSize.SMALL:
			%SpriteHolder.scale = Vector2(0.005, 0.005)

func set_texture():
	if type == TileObj.TileType.BOX:
		%Sprite.texture = texture
		%Sprite.modulate.a = 1.0
	else:
		%Sprite.texture = crushed_texture
		%Sprite.modulate.a = 0.5
		

func ProcessAnimationEvent(event: AnimationEvent):
	match event.anim_type:
		AnimationEvent.AnimationType.MOVED:
			posn = event.new_posn
			%SpriteHolder.position = event.new_posn
		AnimationEvent.AnimationType.CRUSHED:
			type = TileObj.TileType.CRUSHED_BOX
			set_texture()
		_:
			super.ProcessAnimationEvent(event)
	
