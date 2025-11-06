extends PlayerBaseController 
class_name PlayerControllerStageFour

@export var acceleration: float

var horizontal_direction: float
var vertical_direction: float

func handle_movement() -> void:
	horizontal_direction = Input.get_axis("ui_left", "ui_right")
	vertical_direction = Input.get_axis("ui_up", "ui_down")
	
	var test_dir = Vector2(horizontal_direction, vertical_direction).normalized()

	velocity = velocity.lerp(test_dir * 30.0, acceleration)
	print(velocity)

func handle_gravity(_delta: float) -> void:
	return

func handle_jump() -> void:
	return

func check_tile_color() -> void:
	return
