extends Node2D

func start_dialog(dialogue_path: String) -> void:
	var current_dialogue_resource = load(dialogue_path)
	var node = DialogueManager.show_dialogue_balloon(current_dialogue_resource)
	self.add_child(node)
	
func hide_all() -> void:
	for child in get_children():
		child.visible = false
	
func show_all() -> void:
	for child in get_children():
		child.visible = true
