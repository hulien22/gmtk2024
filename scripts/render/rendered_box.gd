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
			StartNewTween()
			tween.tween_property(%SpriteHolder, "position", Vector2(event.new_posn.x, event.new_posn.y), AnimationConstants.MOVE)
			tween.parallel().tween_property(%Sprite, "scale", Vector2(0.9,0.9), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_OUT)
			tween.tween_property(%Sprite, "scale", Vector2(1,1), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_IN)
			
		AnimationEvent.AnimationType.CRUSHED:
			type = TileObj.TileType.CRUSHED_BOX
			
			#StartNewTween()
			#tween.tween_property(%SpriteHolder, "position", Vector2(posn.x, posn.y), 0.001)
			#tween.parallel().tween_property(%Sprite, "scale", Vector2(1,1), AnimationConstants.LONG_ANIM) # SLEEP
			#tween.tween_callback(set_texture)
			set_texture()
		_:
			super.ProcessAnimationEvent(event)
	
