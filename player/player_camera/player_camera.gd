extends Camera2D
class_name PlayerCamera

func _ready() -> void:
	if GameManager.current_stage == GameManager.CurrentStage.STAGE_1:
		offset.x = 97.0
		offset.y = -74.0

		limit_top = 74
		limit_right = 960
		limit_bottom = 106
	elif GameManager.current_stage == GameManager.CurrentStage.STAGE_2:
		position_smoothing_enabled = true
		position_smoothing_speed = 3.0

		drag_vertical_enabled = true
		drag_top_margin = 0.4
		drag_bottom_margin = 0.4
		
		limit_left = 0
		limit_top = -350
		limit_right = 320
		limit_bottom = 180
