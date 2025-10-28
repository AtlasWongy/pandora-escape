extends Area2D
class_name DeathZoneBaseClass

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	# handle_transform_and_behaviour()

#func handle_transform_and_behaviour() -> void:
#	var scene_root: String = str(get_parent().name)
#	print(scene_root)
#	match scene_root:
#		"Stage1":
#			global_position = Vector2(10.0, 190.0)
#			
#		_:
#			print("What the HELI")

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerBaseController:
		SignalBus.player_died.emit()
	else:
		return
