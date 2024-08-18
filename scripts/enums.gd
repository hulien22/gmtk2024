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
	BROWN,
	DARKBLUE,
	DARKGREEN,
	LIGHTBLUE,
	LIGHTGREEN,
	MAGENTA,
	ORANGE,
	PINK,
	PURPLE,
	RED,
	NONE
};
const COLOR_MAX:int = 10;
