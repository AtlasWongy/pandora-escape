extends Node

enum GameState {GAME_RUNNING, GAME_OVER, GAME_WON}

var stages: Dictionary[int, Resource] = {
	1: preload("res://levels/stage1/stage1.tscn"),
	2: preload("res://levels/stage2/stage2.tscn")
}
var current_game_state: GameState
var player_attempts: int = 0

func _ready() -> void:
	SignalBus.player_died.connect(_on_player_death)
	SignalBus.player_won.connect(_on_player_won)
	SignalBus.level_restarted.connect(_on_level_restart)
	SignalBus.level_proceeded.connect(_on_level_proceeded)

func _on_player_death() -> void:
	get_tree().paused = true
	current_game_state = GameState.GAME_OVER	
	SignalBus.game_over_screen_appeared.emit()
	
func _on_player_won() -> void:
	get_tree().paused = true
	current_game_state = GameState.GAME_WON  
	SignalBus.game_over_screen_appeared.emit()
	
func _on_level_restart() -> void:
	get_tree().reload_current_scene()
	get_tree().paused = false
	current_game_state = GameState.GAME_RUNNING
	player_attempts += 1
	
func _on_level_proceeded() -> void:
	get_tree().change_scene_to_packed(stages[2])
	get_tree().paused = false
	current_game_state = GameState.GAME_RUNNING
	player_attempts = 0
