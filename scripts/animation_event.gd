extends Resource
class_name AnimationEvent

enum AnimationType {
	MOVED,
	CRUSHED,
	ACTIVATED,
	DEACTIVATED,
	# For the smaller guy
	SPAWNED,
	RETURNED,
	# For the larger body
	DECAPITATE,
	REVIVE,
	LEVEL_COMPLETE_SMALL,
	LEVEL_COMPLETE_MEDIUM,
	LEVEL_COMPLETE_BIG,
}

@export var obj_type: TileObj.TileType
@export var posn: Vector2i
@export var anim_type: AnimationType

@export var new_posn: Vector2i
@export var direction: Enums.Direction
@export var size: TileObj.TileSize
