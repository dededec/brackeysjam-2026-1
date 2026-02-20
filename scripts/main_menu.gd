extends Node2D
@onready var animation_player: AnimationPlayer = $transition/AnimationPlayer

func _on_button_pressed() -> void:
	animation_player.play("close")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/consult.tscn")
