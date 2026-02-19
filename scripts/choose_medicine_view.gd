extends Node2D

var is_on_medicine_area: bool = false
var medicines: Array[String] = []
@onready var pill: Node2D = $Pill

func _on_add_medicine_area_body_entered(_body: Node2D) -> void:
	is_on_medicine_area = true

func _on_add_medicine_area_body_exited(_body: Node2D) -> void:
	is_on_medicine_area = false
	
func _on_medicine_dropped(medicine_name: String) -> void:
	if(medicines.size() < 3) and is_on_medicine_area:
		medicines.push_back(medicine_name)
		pill.show_medicine(medicine_name, medicines.size())


func _on_pill_medicine_erased(index: int) -> void:
	medicines.remove_at(index)
