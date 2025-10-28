extends DeathZoneBaseClass
class_name DeathZoneStageTwo

@export var platform_movement_speed: float = 10.0

func _physics_process(delta: float) -> void:
	handle_death_zone_movement(delta)
	
func handle_death_zone_movement(delta: float) -> void:
	global_position.y += platform_movement_speed * -1.0 * delta
