extends PlayerBaseController
class_name PlayerControllerStageOne

func handle_movement() -> void:
	velocity.x = move_speed * 1.0
