extends Node

@onready var audio_stream_player: AudioStreamPlayer = $"AudioStreamPlayer"

var stage_1_audio = preload("res://singletons/audio_manager/bgm/space_main_theme.mp3")
var stage_2_audio = preload("res://singletons/audio_manager/bgm/astral_float.mp3")
var music_progress: float = 0.0

func _ready() -> void:
	SignalBus.level_restarted.connect(_on_level_restarted)
	
	set_audio_resource_and_play()

func set_audio_resource_and_play() -> void:
	if GameManager.current_stage == GameManager.CurrentStage.STAGE_1:
		audio_stream_player.stream = stage_1_audio
		audio_stream_player.play(music_progress)
	elif GameManager.current_stage == GameManager.CurrentStage.STAGE_2:
		audio_stream_player.stream = stage_2_audio
		audio_stream_player.play(music_progress)

func _on_level_restarted() -> void:
	music_progress = audio_stream_player.get_playback_position()
	audio_stream_player.play(music_progress)
