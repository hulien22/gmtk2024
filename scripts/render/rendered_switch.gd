extends RenderedObj
class_name RenderedSwitch

var activated:bool

func init(obj: TileObj):
	super.init(obj)
	activated = obj.activated
	%SpriteHolder.position = obj.posn
	match obj.size:
		TileObj.TileSize.BIG:
			%SpriteHolder.scale = Vector2(0.02, 0.02)
		TileObj.TileSize.MEDIUM:
			%SpriteHolder.scale = Vector2(0.01, 0.01)
		TileObj.TileSize.SMALL:
			%SpriteHolder.scale = Vector2(0.005, 0.005)
	%Sprite.texture = ArtManager.get_switch(activated, color)

func ProcessAnimationEvent(event: AnimationEvent):
	match event.anim_type:
		AnimationEvent.AnimationType.ACTIVATED:
			activated = true
		AnimationEvent.AnimationType.DEACTIVATED:
			activated = false
		_:
			super.ProcessAnimationEvent(event)
	AudioManager.play_lever()
	%Sprite.texture = ArtManager.get_switch(activated, color)
