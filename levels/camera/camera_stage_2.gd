extends Camera2D
class_name CameraStage2

@export var player: PlayerBaseController
@export var camera_smoothing: float
@export var offset_limit: float

var player_offset: float
var target_position_for_camera: float
var can_update_camera_position: bool

func _process(delta: float) -> void: 
	player_offset = global_position.y - player.global_position.y
	print("The player offset: ", player_offset)
	if abs(player_offset) < offset_limit and can_update_camera_position:
		target_position_for_camera -= 70.0
		#print("The target position for the camera: ", target_position_for_camera)
		can_update_camera_position = false
	global_position = global_position.lerp(Vector2(0.0, target_position_for_camera), camera_smoothing * delta)
	#print("Camera Position: ", global_position.y)
	if check_if_camera_reached_new_position(global_position.y, target_position_for_camera): 
		can_update_camera_position = true
		
func check_if_camera_reached_new_position(camera_position: float, target_position: float) -> bool:
	if camera_position - target_position <= 5.0:
		return true
	return false
