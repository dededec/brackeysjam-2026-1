extends Node2D

signal medicine_erased(index: int)

@onready var medicine_slots: Array[TextureButton] = [$First, $Second, $Third]

func show_medicine(medicine_name: String, index: int) -> void:
	medicine_slots[index -1].texture_normal = load("res://icon.svg")
	
func move_sprites_back() -> void:
	if medicine_slots[1].texture_normal != null:
		medicine_slots[0].texture_normal = medicine_slots[1].texture_normal
		medicine_slots[1].texture_normal = null
	if medicine_slots[2].texture_normal != null:
		medicine_slots[1].texture_normal = medicine_slots[2].texture_normal
		medicine_slots[2].texture_normal = null

func _on_first_button_down() -> void:
	medicine_slots[0].texture_normal = null
	move_sprites_back()
		
	medicine_erased.emit(0)

func _on_second_button_down() -> void:
	medicine_slots[1].texture_normal = null
	move_sprites_back()
	
	medicine_erased.emit(1)

func _on_third_button_down() -> void:
	medicine_slots[2].texture_normal = null
	
	medicine_erased.emit(2)
