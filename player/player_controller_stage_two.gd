extends PlayerBaseController
class_name PlayerControllerStageTwo

@export var double_jump_multiplier: float

var direction: float
var can_double_jump: bool = true

func handle_movement() -> void:
	direction = Input.get_axis("move_left", "move_right")
	velocity = velocity.lerp(Vector2(move_speed * direction, velocity.y), 0.5)
	
func handle_jump() -> void:
	if is_on_floor(): #and (!can_coyote):
		can_coyote = true
		can_double_jump = true

	if Input.is_action_just_pressed("ui_accept") and jump_buffer_timer.is_stopped():
		jump_buffer_timer.start(jump_buffer_time)
		player_audio.play_jump_audio()
	
	if !jump_buffer_timer.is_stopped() and (is_on_floor() or can_coyote):
		velocity.y = jump_velocity
		jump_buffer_timer.stop()
		can_coyote = false
	
	if Input.is_action_just_pressed("ui_accept") and can_double_jump and !is_on_floor() and velocity.y < 0.0: 
		velocity.y = jump_velocity * double_jump_multiplier
		can_double_jump = false

	if !is_on_floor() and velocity.y > 0.0 and velocity.x != 0.0 and can_coyote:
		coyote_timer.start(coyote_time)
		await coyote_timer.timeout
		can_coyote = false

func change_color(event: InputEventKey) -> void:
	if event.keycode == KEY_A:
		player_sprite.material.set_shader_parameter("new_color", Vector4(0.6745, 0.1961, 0.1961, 1.0))
		color_state = Vector2i(0, 0) 
	elif event.keycode == KEY_S:
		player_sprite.material.set_shader_parameter("new_color", Vector4(0.3569, 0.4314, 0.8824, 1.0)) 
		color_state = Vector2i(1, 0)
	elif event.keycode == KEY_D:
		player_sprite.material.set_shader_parameter("new_color", Vector4(0.4157, 0.7451, 0.1882, 1.0))
		color_state = Vector2i(2, 0) 
