extends Node

enum GameState {GAME_RUNNING, GAME_OVER}

var current_game_state: GameState

func _ready() -> void:
	SignalBus.player_died.connect(_on_player_death)
	SignalBus.level_restarted.connect(_on_level_restart)

func _on_player_death() -> void:
	get_tree().paused = true
	SignalBus.game_over_screen_appeared.emit()
	current_game_state = GameState.GAME_OVER

func _on_level_restart() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false
	current_game_state = GameState.GAME_RUNNING
