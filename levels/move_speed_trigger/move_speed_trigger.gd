extends Area2D
class_name MoveSpeedTriggerArea

@export var move_speed_value: float = 30.0

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerBaseController:
		body.move_speed = move_speed_value
