extends Node2D

var is_on_medicine_area: bool = false
var medicine: Array[String] = []

func _on_add_medicine_area_body_entered(_body: Node2D) -> void:
	is_on_medicine_area = true

func _on_add_medicine_area_body_exited(_body: Node2D) -> void:
	is_on_medicine_area = false
	
func _on_medicine_dropped(medicine_name: String) -> void:
	print(medicine_name)
