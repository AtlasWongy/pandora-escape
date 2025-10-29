extends CharacterBody2D
class_name PlayerBaseController

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
@onready var jump_buffer_timer: Timer = $"Timers/JumpBufferTimer"
@onready var coyote_timer: Timer = $"Timers/CoyoteTimer"
@onready var player_audio: PlayerAudio = $"PlayerAudio"

var color_map: Dictionary = {
	4194319: [Vector2i(0, 0), Vector4(0.6745, 0.1961, 0.1961, 1.0)], # Left Arrow Key | Red
	4194322: [Vector2i(1, 0), Vector4(0.3569, 0.4314, 0.8824, 1.0)], # Down Arrow Key | Blue
	4194321: [Vector2i(2, 0), Vector4(0.4157, 0.7451, 0.1882, 1.0)]  # Right Arrow Key | Green 
}
var can_coyote: bool = false
var color_state: Vector2i 
var tile_color: Vector2i
var early_end_jump_modifier: float = 1.0
var tween: Tween

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
	move_and_slide()
	check_tile_color()

func handle_movement() -> void:
	print("Subclass must implement the required function: handle_movement()")

func handle_gravity(delta: float) -> void:
	if is_on_floor():
		velocity.y = 0.0
		early_end_jump_modifier = 1.0
	elif velocity.y < 0.0:
		velocity.y += jump_gravity * early_end_jump_modifier * delta 
	else:
		velocity = velocity.lerp(Vector2(velocity.x, fall_gravity), delta * 0.9)	

func handle_jump() -> void:
	if is_on_floor() and !can_coyote:
		can_coyote = true
	
	if Input.is_action_just_pressed("ui_accept") and jump_buffer_timer.is_stopped():
		jump_buffer_timer.start(jump_buffer_time)
		player_audio.play_jump_audio()
	
	if !jump_buffer_timer.is_stopped() and (is_on_floor() or can_coyote):
		velocity.y = jump_velocity
		jump_buffer_timer.stop()
		can_coyote = false
	
	if !is_on_floor() and velocity.y > 0.0 and velocity.x != 0.0 and can_coyote:
		coyote_timer.start(coyote_time)
		await coyote_timer.timeout
		can_coyote = false

func change_color(event: InputEventKey) -> void:	
	var color_selection = color_map[event.keycode][1]
	player_sprite.material.set_shader_parameter("new_color", color_selection)
	color_state = color_map[event.keycode][0]	

func check_tile_color()-> void:
	if raycast.get_collider() is TileMapLayer:
		var tile_map: TileMapLayer = raycast.get_collider()
		tile_color = tile_map.get_cell_atlas_coords(tile_map.get_coords_for_body_rid(raycast.get_collider_rid()))
		if color_state != tile_color:
			if tile_check_timer.is_stopped() and is_on_floor():
				tile_check_timer.start()
			await tile_check_timer.timeout
			if color_state != tile_color:
				# Seems to be the only way to cleanly emit the signal once
				SignalBus.player_died.emit()
				color_state = tile_color
	elif raycast.get_collider() is not TileMapLayer and tile_check_timer.time_left > 0.0:
		tile_check_timer.stop()
		tile_color = Vector2i.ZERO

func play_jump_rotation_tween() -> void:
	if tween:
		if tween.is_running():
			return
		else:
			tween.kill()
	tween = create_tween()
	tween.tween_property(player_sprite, "rotation", 1.571, jump_time_to_peak + jump_time_to_descent).as_relative().from_current()
