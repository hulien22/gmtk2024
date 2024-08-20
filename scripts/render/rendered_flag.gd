extends RenderedObj
class_name RenderedFlag

@export var texture: Texture

func init(obj: TileObj):
	super.init(obj)
	%SpriteHolder.position = obj.posn
	%Sprite.texture = texture
	match obj.size:
		TileObj.TileSize.BIG:
			%SpriteHolder.scale = Vector2(0.02, 0.02)
		TileObj.TileSize.MEDIUM:
			%SpriteHolder.scale = Vector2(0.01, 0.01)
		TileObj.TileSize.SMALL:
			%SpriteHolder.scale = Vector2(0.005, 0.005)

func ProcessAnimationEvent(event: AnimationEvent):
	match event.anim_type:
		AnimationEvent.AnimationType.ACTIVATED:
			StartNewTween()
			#tween.tween_property(%Sprite, "rotation_degrees", 360, AnimationConstants.LONG_LONG_ANIM)
			#tween.parallel().tween_property(%Sprite, "scale", Vector2(5,5), AnimationConstants.LONG_LONG_ANIM)
			tween.tween_property(%Sprite, "rotation_degrees", 720, 2* AnimationConstants.LONG_LONG_ANIM).set_trans(Tween.TRANS_QUAD)
			tween.parallel().tween_property(%Sprite, "scale", Vector2(20,20), 2*AnimationConstants.LONG_LONG_ANIM).set_trans(Tween.TRANS_QUAD)
			AudioManager.play_win()
		_:
			super.ProcessAnimationEvent(event)
