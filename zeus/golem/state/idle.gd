extends State

@onready var player_detection: Area2D = $"../../PlayerDetection"
@onready var collision = $"../../PlayerDetection/CollisionShape2D"
@onready var progress_bar = owner.find_child("ProgressBar")

func _ready() -> void:
	player_detection.body_entered.connect(_on_player_detection_body_entered)

var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)
		progress_bar.set_deferred("visible", value)

func transition():
	if player_entered:
		get_parent().change_state("Follow")

func _on_player_detection_body_entered(_body):
	player_entered = true
