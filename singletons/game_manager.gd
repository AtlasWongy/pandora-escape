extends Node

enum GameState {GAME_RUNNING, GAME_OVER, GAME_WON}

var current_game_state: GameState

func _ready() -> void:
	SignalBus.player_died.connect(_on_player_death)
	SignalBus.player_won.connect(_on_player_won)
	SignalBus.level_restarted.connect(_on_level_restart)		

func _on_player_death() -> void:
	get_tree().paused = true
	current_game_state = GameState.GAME_OVER  
	
	SignalBus.game_over_screen_appeared.emit()
	
func _on_player_won() -> void:
	get_tree().paused = true
	SignalBus.game_over_screen_appeared.emit()	
	current_game_state = GameState.GAME_WON 

func _on_level_restart() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false
	current_game_state = GameState.GAME_RUNNING
