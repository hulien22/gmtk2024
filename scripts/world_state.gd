extends Node

var first_load:bool = true

var active_level:int = 0;
var num_stars: int = 3;
var color_states:Array[bool] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

# Make sure WorldState is loaded after all of these
var level_infos: Array[LevelInfo] = [
	LevelBasic,
	LevelMountain,
	LevelLockpick,
	LevelKey,
	LevelTrapped,
]

var levels: Array[Level] = []

func LoadLevels():
	for li in level_infos:
		var level = Level.new()
		level.LoadLevelFromText(li.level_str)
		level.level_name = li.level_name
		levels.push_back(level)

func _init():
	LoadLevels()
