extends CharacterBody2D

func _physics_process(delta: float) -> void:
	print("Current Velocity: ", velocity)
	velocity = velocity.lerp(Vector2(5.0, 0.0), 0.1)
	move_and_slide()
