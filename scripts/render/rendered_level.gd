extends Node2D

@export var border_size: int = 10
@export var tile_size: int = 3

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
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
