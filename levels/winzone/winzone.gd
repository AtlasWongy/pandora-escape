extends Area2D
class_name Winzone

func _ready() -> void:
	self.body_entered.connect(_on_body_shape_entered)

func _on_body_shape_entered(_body: Node2D) -> void:
	SignalBus.player_won.emit()
	return
