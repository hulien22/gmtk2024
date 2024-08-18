extends Node2D
class_name RenderedLevel

@export var border_size: int = 10
@export var tile_size: int = 3

@export var button_scn: PackedScene
@export var switch_scn: PackedScene



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init(data: Level):
	$BackgroundLayer.init(data, border_size)
	$GridOffset.position = Vector2i(border_size*tile_size, border_size*tile_size)
	$GridOffset.scale = Vector2i(tile_size, tile_size)
	$GridOffset/PB.init(data, TileObj.TileSize.BIG)
	$GridOffset/PM.init(data, TileObj.TileSize.MEDIUM)
	$GridOffset/PS.init(data, TileObj.TileSize.SMALL)
	for obj in data.CurrentState().bg_objects:
		if obj is ButtonObj:
			var node = button_scn.instantiate()
			node.init(obj)
			$GridOffset/Buttons.add_child(node)
		elif obj is SwitchObj:
			#var node = button_scn.instantiate()
			#node.init(obj)
			#$GridOffset.add_child(node)
			pass

func ProcessAnimationEvents(events: Array[AnimationEvent]):
	for event in events:
		# find corresponding object
		print("EVENT: ", var_to_str(event))
	pass
	
