extends State

var can_transition: bool = false

func enter() -> void:
	super.enter()
	animation_player.play("Glowing")
	await dash()
	can_transition = true

func dash() -> void:
	var tween = create_tween()
	tween.tween_property(owner, "position", player.position, 0.8)
	await tween.finished

func transition() -> void:
	if can_transition:
		can_transition = false

		get_parent().change_state("Follow")
