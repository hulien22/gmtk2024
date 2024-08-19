extends Node2D
class_name RenderedObj

const base_scale: float = 1

var posn: Vector2i
var type: TileObj.TileType
var size: TileObj.TileSize
var color: Enums.Colors
var direction: Enums.Direction

var tween:Tween

func init(obj: TileObj):
	type = obj.type
	posn = obj.posn
	color = obj.color
	size = obj.size
	direction = obj.direction

func ProcessAnimationEvent(event: AnimationEvent):
	print("ERROR COULD NOT PROCESS ANIMATION EVENT: ", var_to_str(event))

func KillPrevTween():
	if tween:
		tween.kill()
	# TODO: Force posn?

func StartNewTween():
	KillPrevTween()
	tween = get_tree().create_tween()

#var frame: int :
	#set(value):
		#(%AnimatedSprite2D as AnimatedSprite2D).set_frame(value)
		#value = frame

#func set_posn(p: Vector2i):
	#posn = p
	#%SpriteHolder.position = posn
