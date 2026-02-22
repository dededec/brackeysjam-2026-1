extends Node2D
@onready var animation_player: AnimationPlayer = $transition/AnimationPlayer

var allow_start = false

func _input(event: InputEvent) -> void:
	if event.is_action("left_clic") and allow_start:
		animation_player.play("close")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/consult.tscn")


func _on_allow_start_timer_timeout() -> void:
	allow_start = true
