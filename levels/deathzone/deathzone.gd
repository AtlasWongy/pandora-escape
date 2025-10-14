extends Area2D
class_name DeathZone

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
	SignalBus.player_died.emit()	
