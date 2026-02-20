extends Node2D

@onready var pov: AnimatedSprite2D = $pov
@onready var computer_area: Area2D = $computer_area
@onready var choose_medicine_view: Node2D = $ChooseMedicineView
@onready var doctor_pov: Node2D = $doctor_pov
@onready var patient_pov: Node2D = $patient_pov

func _ready() -> void: 
	randomize()
	Manager.register_doctor(doctor_pov)
	Manager.register_patient(patient_pov)
	Manager.register_computer(choose_medicine_view)
	computer_area.mouse_entered.connect(Manager._on_computer_area_mouse_entered)
	computer_area.mouse_exited.connect(Manager._on_computer_area_mouse_exited)
