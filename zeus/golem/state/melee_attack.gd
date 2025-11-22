extends State

func enter() -> void:
	super.enter()
	animation_player.play("MeleeAttack")

func transition() -> void:
	if owner.direction.length() > 30.0:
		get_parent().change_state("Follow")
