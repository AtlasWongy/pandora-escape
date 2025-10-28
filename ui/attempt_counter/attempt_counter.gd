extends MarginContainer
class_name AttemptCounter

@onready var attempt_count_label: RichTextLabel = $"AttemptCounterHorizontalBox/AttemptCount"

func _ready() -> void:
	attempt_count_label.text = str(GameManager.player_attempts)
