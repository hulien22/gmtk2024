extends Node

var first_load:bool = true

var active_level:int = 0;
var num_stars: int = 6;

# Make sure WorldState is loaded after all of these
var level_infos: Array[LevelInfo] = [
	LevelBasic,
	LevelTraffic,
	LevelLockpick,
	LevelGate,
	LevelSimpleWeird,
	LevelMountain,
	LevelKey,
	LevelTrapped,
	LevelBacktobasic
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

func GetGlobalColorStates(new_state:LevelState, skip_level: Level) -> Array[bool]:
	var color_states:Array[bool] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	for l in levels:
		if l == skip_level:
			continue
		for i in range(Enums.COLOR_MAX):
			# Do an XOR to combine
			color_states[i] = color_states[i] != l.CurrentState().level_color_states[i]
	for i in range(Enums.COLOR_MAX):
		# Do an XOR to combine
		color_states[i] = color_states[i] != new_state.level_color_states[i]
	return color_states
