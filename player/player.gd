# Tasks to do
# Input Buffering [x]
# Coyote Time [x]
# Check Calculation for Short Jump [x]
# Refactor [x]
# Adjust Fall Speed []

extends CharacterBody2D
class_name Player

@export var move_speed: float
@export var jump_height: float
@export var jump_time_to_peak: float 
@export var jump_time_to_descent: float
@export var jump_buffer_time: float
@export var coyote_time: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@onready var player_sprite: Sprite2D = $"PlayerSprite"
@onready var raycast: RayCast2D = $"PlayerRayCast"
@onready var tile_check_timer: Timer = $"Timers/TileCheckTimer"
@onready var jump_buffer_timer = $"Timers/JumpBufferTimer"
@onready var coyote_timer = $"Timers/CoyoteTimer"

var color_map: Dictionary = {
	4194319: [Vector2i(0, 0), Vector4(0.6745, 0.1961, 0.1961, 1.0)], # Left Arrow Key | Red
	4194322: [Vector2i(1, 0), Vector4(0.3569, 0.4314, 0.8824, 1.0)], # Down Arrow Key | Blue
	4194321: [Vector2i(2, 0), Vector4(0.4157, 0.7451, 0.1882, 1.0)]  # Right Arrow Key | Green 
}
var color_state: Vector2i 
var early_end_jump_modifier: float = 1.0

func _ready() -> void:
	color_state = color_map[4194319][0]
	player_sprite.material.set_shader_parameter("new_color", color_map[4194319][1])

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("change_color"):
		change_color(event)

	if event.is_action_released("ui_accept"): 
		early_end_jump_modifier = 2.0

func _physics_process(delta: float) -> void:
	
	handle_gravity(delta)
	handle_jump()	
	handle_movement()
	check_tile_color()

func handle_movement() -> void:
	velocity.x = move_speed * 1.0
	move_and_slide()

func handle_gravity(delta: float) -> void:
	if is_on_floor():
		velocity.y = 0.0
	elif velocity.y < 0.0:
		velocity.y += jump_gravity * early_end_jump_modifier * delta 
	else:
		velocity = velocity.lerp(Vector2(velocity.x, fall_gravity), delta * 0.9)	

func handle_jump() -> void:
	if Input.is_action_just_pressed("ui_accept"):                                         
		jump_buffer_timer.start(jump_buffer_time)                                         

	if !jump_buffer_timer.is_stopped() and (is_on_floor() or !coyote_timer.is_stopped()): 
		velocity.y = jump_velocity
		jump_buffer_timer.stop()
		coyote_timer.stop()
	
func change_color(event: InputEventKey) -> void:	
	var color_selection = color_map[event.keycode][1]
	player_sprite.material.set_shader_parameter("new_color", color_selection)
	color_state = color_map[event.keycode][0]	

func check_tile_color()-> void:

	if is_on_floor() and raycast.is_colliding():
		early_end_jump_modifier = 1.0
		
		if raycast.get_collider() is TileMapLayer:
			var tile_map: TileMapLayer = raycast.get_collider()
			var tile_color: Vector2i = tile_map.get_cell_atlas_coords(tile_map.get_coords_for_body_rid(raycast.get_collider_rid()))
			if color_state != tile_color:
				if tile_check_timer.is_stopped():
					tile_check_timer.start()
				await tile_check_timer.timeout
				if color_state != tile_color:
					SignalBus.player_died.emit()

	elif !is_on_floor() and velocity.y > 0.0 and velocity.x != 0.0 and coyote_timer.is_stopped(): 
		coyote_timer.start(coyote_time) 	
