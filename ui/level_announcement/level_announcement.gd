extends Control
class_name LevelAnnoucement

@onready var stage_name_label: RichTextLabel = $"StageNameLabel"
@onready var annoucement_banner_left: TextureRect = $"AnnoucementBannerLeft"
@onready var annoucement_banner_right: TextureRect = $"AnnoucementBannerRight"

var stage_names: Dictionary[String, String] = {
	"Stage 1": "Escape",
	"Stage 2": "Ascend",
	"Stage 3": "Ponder",
	"Stage 4": "Destroy"
}

var tween_banners: Tween
var tween_stages: Tween
var current_stage: StringName

func _ready() -> void:
	
	if GameManager.players_attempts[GameManager.current_stage] > 0:
		queue_free()

	set_initial_label_values()

	if tween_banners and tween_stages:
		tween_banners.kill()
		tween_stages.kill()
	tween_banners = create_tween()
	tween_stages = create_tween()

	tween_banners.set_parallel()
	tween_banners.tween_property(annoucement_banner_left, "position", Vector2.RIGHT * 120, 1).as_relative()
	tween_banners.tween_property(annoucement_banner_right, "position", Vector2.LEFT * 120, 1).as_relative()
	
	tween_stages.set_ease(Tween.EASE_OUT).set_trans(Tween.TransitionType.TRANS_SPRING)  
	tween_stages.tween_property(stage_name_label, "position", Vector2.DOWN * 100, 1).as_relative()
	tween_stages.tween_interval(0.5)
	tween_stages.tween_callback(_on_stage_name_label_tween_finished)
	tween_stages.tween_property(stage_name_label, "position", Vector2.DOWN * 100, 1).as_relative()
	tween_stages.tween_callback(_on_stage_name_label_tween_disappearing) 
	tween_stages.tween_property(stage_name_label, "modulate:a", 0.0, 1.0)

func set_initial_label_values() -> void:
	stage_name_label.text = GameManager.CurrentStage.keys()[GameManager.current_stage].replace("_", " ")

func _on_stage_name_label_tween_finished() -> void:
	stage_name_label.position.y = -100
	stage_name_label.text = GameManager.current_stage_name 

func _on_stage_name_label_tween_disappearing() -> void:
	if tween_banners:
		tween_banners.kill()
	tween_banners = create_tween().set_parallel()
	tween_banners.tween_property(annoucement_banner_left, "position", Vector2.LEFT * 120, 1).as_relative()
	tween_banners.tween_property(annoucement_banner_right, "position", Vector2.RIGHT * 120, 1).as_relative()
