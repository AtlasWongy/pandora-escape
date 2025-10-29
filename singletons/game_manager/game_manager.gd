extends Node

enum GameState {GAME_RUNNING, GAME_OVER, GAME_WON}
enum CurrentStage {STAGE_1, STAGE_2, STAGE_3, STAGE_4}

@export var current_stage: CurrentStage

var stages: Dictionary[int, Resource] = {
	1: preload("res://levels/stage1/stage1.tscn"),
	2: preload("res://levels/stage2/stage2.tscn")
}
var current_game_state: GameState
var current_stage_name: String
var players_attempts: Dictionary[CurrentStage, int] = {
	CurrentStage.STAGE_1: 0,
	CurrentStage.STAGE_2: 0,
	CurrentStage.STAGE_3: 0,
	CurrentStage.STAGE_4: 0
}

func _ready() -> void:
	
	map_current_stage_name()

	SignalBus.player_died.connect(_on_player_death)
	SignalBus.player_won.connect(_on_player_won)
	SignalBus.level_restarted.connect(_on_level_restart)
	SignalBus.level_proceeded.connect(_on_level_proceeded)

func handle_new_current_stage_increment() -> void:
	current_stage = GameManager.CurrentStage.keys()[current_stage + 1]

func map_current_stage_name() -> void:
	if current_stage == GameManager.CurrentStage.STAGE_1:
		current_stage_name = "Escape"
	elif current_stage == GameManager.CurrentStage.STAGE_2: 
		current_stage_name = "Ascend"                     
	elif current_stage == GameManager.CurrentStage.STAGE_3: 
		current_stage_name = "Ponder"                     
	elif current_stage == GameManager.CurrentStage.STAGE_4: 
		current_stage_name = "Destroy"                     

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
	players_attempts[current_stage] += 1
		
func _on_level_proceeded() -> void:
	get_tree().change_scene_to_packed(stages[2])
	current_stage = GameManager.CurrentStage.STAGE_2
	handle_new_current_stage_increment()
	map_current_stage_name()
	get_tree().paused = false
	current_game_state = GameState.GAME_RUNNING
