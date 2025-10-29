extends Node

@onready var audio_stream_player: AudioStreamPlayer = $"AudioStreamPlayer"

var stage_1_audio = preload("res://singletons/audio_manager/bgm/space_main_theme.mp3")

func _ready() -> void:
	SignalBus.level_restarted.connect(_on_level_restarted)
	
	set_audio_resource_and_play()

func set_audio_resource_and_play() -> void:
	if GameManager.current_stage == GameManager.CurrentStage.STAGE_1:
		audio_stream_player.stream = stage_1_audio
		audio_stream_player.play()

func _on_level_restarted() -> void:
	audio_stream_player.play()
