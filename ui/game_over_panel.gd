class_name GameOverPanel
extends PanelContainer

@onready var game_over_label = $"GameOverVerticalBox/GameOverLabel"
@onready var play_again_label = $"GameOverVerticalBox/PlayAgainLabel"

@export var game_over_message_resource: Resource

func _ready() -> void:
    # connect signals
    return
