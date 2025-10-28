extends Area2D
class_name Winzone

func _ready() -> void:
	self.body_entered.connect(_on_body_shape_entered)

func _on_body_shape_entered(body: Node2D) -> void:
	if body is PlayerBaseController:
		SignalBus.player_won.emit()
		return
