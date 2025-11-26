extends State

var can_transition: bool = false

func enter() -> void:
	super.enter()
	animation_player.play("ArmorBuff")
	await animation_player.animation_finished
	can_transition = true

func transition() -> void:
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")
