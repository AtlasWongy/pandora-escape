extends State

func enter() -> void:
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("Idle")

func exit() -> void:
	super.exit()
	owner.set_physics_process(false)

func transition() -> void:
	var distance = owner.direction.length()

	if distance < 20:
		get_parent().change_state("MeleeAttack")
	elif distance > 130:
		get_parent().change_state("HomingMissile")
