extends State 

@onready var pivot = $"../../LaserPivot"
var can_transition: bool = false

func enter() -> void:
	super.enter()
	await play_animation("LaserCast")
	await play_animation("Laser")
	can_transition = true

func play_animation(anim_name):
	animation_player.play(anim_name)
	await animation_player.animation_finished

func set_target() -> void:
	pivot.rotation = (owner.direction - pivot.position).angle()

func transition() -> void:
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
