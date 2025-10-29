extends Area2D
class_name DeathZoneBaseClass

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	handle_death_zone_movement(delta)

func handle_death_zone_movement(_delta: float) -> void:
	assert(false, "Subclasses of DeathZoneBaseClass must implement handle_death_zone_movement() !!")
	return

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerBaseController:
		SignalBus.player_died.emit()
	else:
		return
