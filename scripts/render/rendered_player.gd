extends RenderedObj
class_name RenderedPlayer

@export var big_texture: Texture
@export var medium_texture: Texture
@export var small_texture: Texture

func init(obj: TileObj):
	super.init(obj)
	
	# We can also get PLAYERBODY, want that to also be treated as player?
	type = TileObj.TileType.PLAYER
	
	%SpriteHolder.position = obj.posn
	#%SpriteHolder.scale = Vector2(0.04, 0.04)
	match size:
		TileObj.TileSize.BIG:
			%Sprite.texture = big_texture
			%SpriteHolder.scale = Vector2(0.02, 0.02)
		TileObj.TileSize.MEDIUM:
			%Sprite.texture = medium_texture
			%SpriteHolder.scale = Vector2(0.01, 0.01)
		TileObj.TileSize.SMALL:
			%Sprite.texture = small_texture
			%SpriteHolder.scale = Vector2(0.005, 0.005)

func SpawnFromEvent(event: AnimationEvent):
	assert(event.anim_type == AnimationEvent.AnimationType.SPAWNED)
	type = event.obj_type
	posn = event.new_posn
	size = event.size
	direction = event.direction
	
	%SpriteHolder.position = posn
	#%SpriteHolder.scale = Vector2(0.04, 0.04)
	match size:
		TileObj.TileSize.BIG:
			%Sprite.texture = big_texture
			%SpriteHolder.scale = Vector2(0.02, 0.02)
		TileObj.TileSize.MEDIUM:
			%Sprite.texture = medium_texture
			%SpriteHolder.scale = Vector2(0.01, 0.01)
		TileObj.TileSize.SMALL:
			%Sprite.texture = small_texture
			%SpriteHolder.scale = Vector2(0.005, 0.005)


func ProcessAnimationEvent(event: AnimationEvent):
	match event.anim_type:
		AnimationEvent.AnimationType.MOVED:
			posn = event.new_posn
			%SpriteHolder.position = event.new_posn
			# TODO Direction
		AnimationEvent.AnimationType.RETURNED:
			queue_free()
		_:
			super.ProcessAnimationEvent(event)
	
