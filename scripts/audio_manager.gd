extends Node

# for music control
@export var lower: float = -60.0
@export var rate: float = 1.0
@export var target: int = 3

# for sound effects
@export var sound_effects: Array[AudioStream]

var music_streams
var sound_effect_player: AudioStreamPlayer
var win_sound_effect_player: AudioStreamPlayer


func _ready() -> void:
	music_streams = $Music.stream.get_clip_stream(1)
	sound_effect_player = $SoundEffects
	win_sound_effect_player = $WinSoundEffect

# for music control
func set_size(size: TileObj.TileSize):
	match size:
		TileObj.TileSize.BIG:
			target = 2
		TileObj.TileSize.MEDIUM:
			target = 1
		TileObj.TileSize.SMALL:
			target = 0

# for music control
func set_level_select(in_level_select: bool):
	if in_level_select:
		target = 3
	else:
		target = 2

# for music control
func set_target(t: int):
	target = clamp(t, 0, 3)

func _process(delta: float) -> void:
	for x in range(4):
		if target < x:
			music_streams.set_sync_stream_volume(x, maxf(lower, music_streams.get_sync_stream_volume(x) - rate))
		else:
			music_streams.set_sync_stream_volume(x, minf(0, music_streams.get_sync_stream_volume(x) + rate))

func play_swallow():
	print("playing swallow")
	sound_effect_player.stream = sound_effects[6]
	sound_effect_player.play()

func play_spit():
	print("playing spit")
	sound_effect_player.stream = sound_effects[5]
	sound_effect_player.play()

func play_scissors():
	print("playing scissors")
	sound_effect_player.stream = sound_effects[4]
	sound_effect_player.play()
	
func play_lever():
	print("playing lever")
	sound_effect_player.stream = sound_effects[3]
	sound_effect_player.play()
	
func play_denied():
	print("playing denied")
	sound_effect_player.stream = sound_effects[2]
	sound_effect_player.play()
	
func play_crush():
	print("playing crush")
	sound_effect_player.stream = sound_effects[1]
	sound_effect_player.play()
	
func play_button():
	print("playing button")
	sound_effect_player.stream = sound_effects[0]
	sound_effect_player.play()

func play_win():
	print("playing win")
	win_sound_effect_player.stream = sound_effects[7]
	win_sound_effect_player.play()
