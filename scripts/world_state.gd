class_name WorldState
# TODO make this a singleton?


# 0 is level select, number corresponds to levels
var active_level:int = 0;

var color_states:Array[bool] = [0, 0, 0, 0, 0, 0];

#var levels:Array[Level] = []

func LoadLevels():
	# load from some resource file
	pass
