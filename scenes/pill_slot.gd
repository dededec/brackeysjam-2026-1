extends Sprite2D

signal slot_clicked

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_pixel_opaque(get_local_mouse_position()):
			slot_clicked.emit()
