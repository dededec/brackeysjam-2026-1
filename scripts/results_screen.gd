extends Node2D

@onready var text_edit: Label = $TextEdit
@onready var end_sprite: AnimatedSprite2D = $EndSprite

func _ready() -> void:
	var healed = str(ScoreManager.healed_patients)
	var total = str(ScoreManager.NUM_OF_PATIENTS)
	text_edit.text = "You healed " + healed + " out of " + total + " patients!"

func _input(event: InputEvent) -> void:
	if event is InputEvent and event.is_action("left_clic"):
		end_sprite.show()
		end_sprite.play("default")


func _on_end_sprite_animation_finished() -> void:
	ScoreManager.reset()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
