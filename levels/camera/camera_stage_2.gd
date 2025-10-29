extends Camera2D
class_name CameraStage2

@export var player: PlayerBaseController
@export var camera_smoothing: float
@export var offset_limit: float

var player_offset: float

func _process(delta: float) -> void:
	player_offset = global_position.y - player.global_position.y
	print(player_offset)
	if abs(player_offset) < offset_limit:
		global_position = global_position.lerp(Vector2(0.0, player.global_position.y - 170.0), camera_smoothing * delta)	
