extends Node2D

signal medicine_erased(index: int)

@onready var medicine_slots: Array[Sprite2D] = [$First, $Second, $Third]

func reset() -> void:
	for slot in medicine_slots:
		slot.texture = null

func show_medicine(medicine_name: String, index: int) -> void:
	var resource = "res://assets/medicinas/small/" + medicine_name + ".png"
	medicine_slots[index -1].texture = load(resource)
	
func move_sprites_back() -> void:
	if medicine_slots[1].texture != null:
		medicine_slots[0].texture = medicine_slots[1].texture
		medicine_slots[1].texture = null
	if medicine_slots[2].texture != null:
		medicine_slots[1].texture = medicine_slots[2].texture
		medicine_slots[2].texture = null

func _on_first_button_down() -> void:
	medicine_slots[0].texture = null
	move_sprites_back()
		
	medicine_erased.emit(0)

func _on_second_button_down() -> void:
	medicine_slots[1].texture = null
	move_sprites_back()
	
	medicine_erased.emit(1)

func _on_third_button_down() -> void:
	medicine_slots[2].texture = null
	
	medicine_erased.emit(2)
