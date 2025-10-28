extends Camera2D

@export var player: PlayerBaseController

func _process(_delta: float) -> void:
	global_position.x = player.global_position.x - 10.0
