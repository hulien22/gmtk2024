extends Node

var first_load:bool = true

var active_level:int = 1;
var num_stars: int = 0;
var color_states:Array[bool] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

#var levels:Array[Level] = []

func LoadLevels():
	# load from some resource file
	pass
