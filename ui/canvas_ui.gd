extends CanvasLayer
class_name CanvasUI

var game_over_screen = preload("res://ui/game_over_panel.tscn")

func _ready() -> void:
	SignalBus.game_over_screen_appeared.connect(_on_game_over_screen_appear)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed() and event.keycode == KEY_SPACE and GameManager.current_game_state == GameManager.GameState.GAME_OVER:
		SignalBus.level_restarted.emit()			
		
func _on_game_over_screen_appear() -> void:
	var game_over_screen_scene = game_over_screen.instantiate()
	add_child(game_over_screen_scene)
