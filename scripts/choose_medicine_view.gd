extends Node2D

var is_on_medicine_area: bool = false
var selected_medicines: Array[String] = []
@onready var pill: Node2D = $Pill
@onready var medicines: Array[AnimatableBody2D] = [$Medicines/Medicine, 
$Medicines/Medicine2, $Medicines/Medicine3, $Medicines/Medicine4, 
$Medicines/Medicine5, $Medicines/Medicine6, $Medicines/Medicine7, $Medicines/Medicine8]
@onready var first: Sprite2D = $Pill/First
@onready var ready_button: TextureButton = $ReadyButton

func reset() -> void:
	selected_medicines = []
	is_on_medicine_area = false
	for medicine in medicines:
		medicine.visible = true
	pill.reset()

func _process(_delta: float) -> void:
	if first.texture:
		ready_button.visible = true
	else:
		ready_button.visible = false

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

func _on_eye_button_pressed() -> void:
	Manager.deactivate_computer()

func _on_ready_button_pressed() -> void:
	#ScoreManager.heal_patient(selected_medicines)
	Manager.pre_pill = selected_medicines
	Manager.deactivate_computer()
