extends Node2D

var is_on_medicine_area: bool = false
var selected_medicines: Array[String] = []
@onready var pill: Node2D = $Pill
@onready var medicines: Array[AnimatableBody2D] = [$Medicines/Medicine, 
$Medicines/Medicine2, $Medicines/Medicine3, $Medicines/Medicine4, 
$Medicines/Medicine5, $Medicines/Medicine6, $Medicines/Medicine7, $Medicines/Medicine8]

func find_medicine_by_name(name: String) -> AnimatableBody2D:
	for medicine in medicines:
		if medicine.name.ends_with(name):
			return medicine
	return null

func _on_add_medicine_area_body_entered(_body: Node2D) -> void:
	is_on_medicine_area = true

func _on_add_medicine_area_body_exited(_body: Node2D) -> void:
	is_on_medicine_area = false
	
func _on_medicine_dropped(medicine_name: String) -> void:
	if(selected_medicines.size() < 3) and is_on_medicine_area:
		selected_medicines.push_back(medicine_name)
		find_medicine_by_name(medicine_name).hide()
		pill.show_medicine(medicine_name, selected_medicines.size())


func _on_pill_medicine_erased(index: int) -> void:
	find_medicine_by_name(selected_medicines[index]).visible = true
	selected_medicines.remove_at(index)
