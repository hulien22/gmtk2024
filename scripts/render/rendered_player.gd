extends RenderedObj
class_name RenderedPlayer

const PLAYER_SIZE:float = 200

@export var big_texture: Texture
@export var medium_texture: Texture
@export var small_texture: Texture

@export var big_open_texture: Texture
@export var medium_open_texture: Texture

func _init():
	%Sprite.centered = true

func init(obj: TileObj):
	super.init(obj)
	
	# We can also get PLAYERBODY, want that to also be treated as player?
	#type = TileObj.TileType.PLAYER
	
	%SpriteHolder.position = obj.posn
	#%SpriteHolder.scale = Vector2(0.04, 0.04)
	match size:
		TileObj.TileSize.BIG:
			if type ==  TileObj.TileType.PLAYER:
				%Sprite.texture = big_texture
			else:
				%Sprite.texture = big_open_texture
			%SpriteHolder.scale = Vector2(0.02, 0.02)
		TileObj.TileSize.MEDIUM:
			if type ==  TileObj.TileType.PLAYER:
				%Sprite.texture = medium_texture
			else:
				%Sprite.texture = medium_open_texture
			%SpriteHolder.scale = Vector2(0.01, 0.01)
		TileObj.TileSize.SMALL:
			%Sprite.texture = small_texture
			%SpriteHolder.scale = Vector2(0.005, 0.005)
	%Sprite.position = Vector2(PLAYER_SIZE/2,PLAYER_SIZE/2)

func SpawnFromEvent(event: AnimationEvent):
	assert(event.anim_type == AnimationEvent.AnimationType.SPAWNED)
	type = event.obj_type
	posn = event.new_posn
	size = event.size
	direction = event.direction
	
	#%SpriteHolder.position = posn
	#%SpriteHolder.scale = Vector2(0.04, 0.04)
	var from_posn:Vector2 = event.posn
	match size:
		TileObj.TileSize.BIG:
			%Sprite.texture = big_texture
			%SpriteHolder.scale = Vector2(0.02, 0.02)
			%SpriteHolder.position = from_posn
		TileObj.TileSize.MEDIUM:
			%Sprite.texture = medium_texture
			%SpriteHolder.scale = Vector2(0.01, 0.01)
			%SpriteHolder.position = from_posn + Vector2(1,1)
		TileObj.TileSize.SMALL:
			%Sprite.texture = small_texture
			%SpriteHolder.scale = Vector2(0.005, 0.005)
			%SpriteHolder.position = from_posn + Vector2(0.5,0.5)
	%Sprite.position = Vector2(PLAYER_SIZE/2,PLAYER_SIZE/2)
	%Sprite.scale = Vector2(0.01,0.01)


func ProcessAnimationEvent(event: AnimationEvent):
	match event.anim_type:
		AnimationEvent.AnimationType.MOVED:
			posn = event.new_posn
			
			StartNewTween()
			tween.tween_property(%SpriteHolder, "position", Vector2(event.new_posn.x, event.new_posn.y), AnimationConstants.MOVE)
			tween.parallel().tween_property(%Sprite, "scale", Vector2(1.1,1.1), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_OUT)
			tween.tween_property(%Sprite, "scale", Vector2(1,1), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_IN)
			# TODO Direction
		AnimationEvent.AnimationType.RETURNED:
			posn = Vector2i(-1,-1) # we're gonna be deleted so get out of here
			StartNewTween()
			var target_posn:Vector2
			match size:
				TileObj.TileSize.BIG:
					# ERROR?
					target_posn = Vector2(event.new_posn.x, event.new_posn.y)
				TileObj.TileSize.MEDIUM:
					target_posn = Vector2(event.new_posn.x + 1, event.new_posn.y + 1)
				TileObj.TileSize.SMALL:
					target_posn = Vector2(event.new_posn.x + 0.5, event.new_posn.y + 0.5)
			tween.tween_property(%SpriteHolder, "position", target_posn, AnimationConstants.MOVE)
			tween.parallel().tween_property(%Sprite, "scale", Vector2(1.5,1.5), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_OUT)
			tween.tween_property(%Sprite, "scale", Vector2(0.01,0.01), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_IN)
			tween.tween_callback(queue_free)
			
		AnimationEvent.AnimationType.SPAWNED:
			StartNewTween()
			tween.tween_property(%SpriteHolder, "position", Vector2(event.new_posn.x, event.new_posn.y), AnimationConstants.MOVE)
			tween.parallel().tween_property(%Sprite, "scale", Vector2(1.5,1.5), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_OUT)
			tween.tween_property(%Sprite, "scale", Vector2(1,1), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_IN)
		
		AnimationEvent.AnimationType.REVIVE:
			type = TileObj.TileType.PLAYER
			match size:
				TileObj.TileSize.BIG:
					%Sprite.texture = big_texture
				TileObj.TileSize.MEDIUM:
					%Sprite.texture = medium_texture
			#StartNewTween()
			#tween.tween_property(%SpriteHolder, "position", Vector2(event.new_posn.x, event.new_posn.y), AnimationConstants.MOVE)
			#tween.parallel().tween_property(%Sprite, "scale", Vector2(1.5,1.5), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_OUT)
			#tween.tween_property(%Sprite, "scale", Vector2(1,1), AnimationConstants.HALF_MOVE).set_ease(Tween.EASE_IN)
		
		AnimationEvent.AnimationType.DECAPITATE:
			type = TileObj.TileType.PLAYER_BODY
			match size:
				TileObj.TileSize.BIG:
					%Sprite.texture = big_open_texture
				TileObj.TileSize.MEDIUM:
					%Sprite.texture = medium_open_texture
		
		_:
			super.ProcessAnimationEvent(event)
	
