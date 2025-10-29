extends PlayerBaseController
class_name PlayerControllerStageTwo

var direction: float
var can_double_jump: bool = true

func handle_movement() -> void:
	direction = Input.get_axis("move_left", "move_right")
	velocity = velocity.lerp(Vector2(30.0 * direction, velocity.y), 0.5)
	print(velocity.x)
	
func handle_jump() -> void:
	return
	#if Input.is_action_just_pressed("ui_accept") and (coyote_timer.time_left > 0.0 or is_on_floor()):                                       
	#	jump_buffer_timer.start(jump_buffer_time)                                         

	#if !jump_buffer_timer.is_stopped() and (is_on_floor() or !coyote_timer.is_stopped()): 
	#	velocity.y = jump_velocity
	#	jump_buffer_timer.stop()
	#	coyote_timer.stop()
	
	#if !is_on_floor() and velocity.y > 0.0 and velocity.x != 0.0 and coyote_timer.is_stopped():
	#coyote_timer.start(coyote_time)
