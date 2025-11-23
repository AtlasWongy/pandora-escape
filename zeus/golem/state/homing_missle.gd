extends State

@export var bullet_node: PackedScene
var can_transition: bool = false

func enter() -> void:
	super.enter()
	animation_player.play("RangedAttack")
	await animation_player.animation_finished
	shoot()
	can_transition = true

func shoot() -> void:
	var bullet = bullet_node.instantiate()
	bullet.position = owner.position
	get_tree().current_scene.add_child(bullet)

func transition() -> void:
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
