class_name Enums

enum Direction {
	UP, RIGHT, DOWN, LEFT
}

static func GetDirection(dir: Direction) -> Vector2i:
	match dir:
		Direction.UP:
			return Vector2i.UP
		Direction.RIGHT:
			return Vector2i.RIGHT
		Direction.DOWN:
			return Vector2i.DOWN
		_:
			return Vector2i.LEFT
			

enum Colors {
	RED,
	ORANGE,
	YELLOW,
	GREEN,
	BLUE,
	PURPLE,
	NONE
};
const COLOR_MAX:int = 6;
