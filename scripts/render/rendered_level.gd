extends Node2D
class_name RenderedLevel

@export var border_size: int = 10
@export var tile_size: int = 3

@export var player_scene: PackedScene
@export var button_scn: PackedScene
@export var box_scn: PackedScene
@export var switch_scn: PackedScene

@export var temp_scn: PackedScene

var objects: Array[RenderedObj] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init(data: Level):
	$BackgroundLayer.init(data, border_size)
	$GridOffset.position = Vector2i(border_size*tile_size, border_size*tile_size)
	$GridOffset.scale = Vector2i(tile_size, tile_size)
	
	for obj in objects:
		obj.queue_free()
	objects.clear()
	
	if true:
		var node = player_scene.instantiate() as RenderedPlayer
		node.init(data.CurrentState().player)
		objects.push_back(node)
		$GridOffset/Player.add_child(node)
	
	for obj in data.CurrentState().bg_objects:
		if obj is ButtonObj:
			var node = button_scn.instantiate() as RenderedButton
			node.init(obj)
			objects.push_back(node)
			$GridOffset/Buttons.add_child(node)
		elif obj is SwitchObj:
			var node = button_scn.instantiate() as RenderedSwitch
			node.init(obj)
			objects.push_back(node)
			$GridOffset/Switches.add_child(node)
			pass
	for obj in data.CurrentState().collision_objects:
		if obj is BoxObj:
			var node = box_scn.instantiate() as RenderedBox
			node.init(obj)
			objects.push_back(node)
			$GridOffset/Boxes.add_child(node)
		elif obj is SwitchObj:
			#var node = button_scn.instantiate()
			#node.init(obj)
			#$GridOffset.add_child(node)
			pass

func ProcessAnimationEvents(events: Array[AnimationEvent]):
	for event in events:
		# Check for special events
		if event.anim_type == AnimationEvent.AnimationType.SPAWNED:
			var node = player_scene.instantiate() as RenderedPlayer
			node.SpawnFromEvent(event)
			objects.push_back(node)
			$GridOffset/Player.add_child(node)
		
		# TODO handle deletion events
		
		# find corresponding object
		var found_obj = false
		for obj in objects:
			if obj.type == event.obj_type && obj.posn == event.posn:
				found_obj = true
				obj.ProcessAnimationEvent(event)
				break
		if !found_obj:
			print("COULD NOT FIND OBJECT FOR EVENT ", var_to_str(event))
	pass
	
