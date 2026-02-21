extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEvent and event.is_action("left_clic"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
