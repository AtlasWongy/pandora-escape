class_name GameOverPanel
extends PanelContainer

@onready var game_over_label:RichTextLabel = $"GameOverVerticalBox/GameOverLabel"
@onready var play_again_label:RichTextLabel = $"GameOverVerticalBox/PlayAgainLabel"

@export var game_over_message_resource: Resource
@export var game_finished_message_resource: Resource

func _ready() -> void:
	set_game_over_label()
	set_play_again_label()

func set_game_over_label() -> void:
	if GameManager.current_game_state == GameManager.GameState.GAME_OVER:
		print("Hello?")
		game_over_label.append_text("[center]" + game_over_message_resource.GameOverTitle + "[/center]")
	elif GameManager.current_game_state == GameManager.GameState.GAME_WON:
		game_over_label.append_text("[center]" + game_finished_message_resource.GameOverTitle + ["center"])

func set_play_again_label() -> void:
	if GameManager.current_game_state == GameManager.GameState.GAME_OVER:
		play_again_label.append_text("[center]" + game_over_message_resource.GameOverSubtitle + "[/center]")
	elif GameManager.current_game_state == GameManager.GameState.GAME_WON:
		play_again_label.append_text("[center]" + game_over_message_resource.GameOverSubtitle + "[/center]")	
