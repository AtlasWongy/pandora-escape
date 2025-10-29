extends AudioStreamPlayer2D
class_name PlayerAudio

@onready var jump_audio = preload("res://player/player_audio/sfx/jump_1.wav")

func play_jump_audio() -> void:
	stream = jump_audio
	play()
