extends Node2D

@onready var pov: AnimatedSprite2D = $pov
@onready var computer_area: Area2D = $computer_area
@onready var choose_medicine_view: Node2D = $ChooseMedicineView
@onready var doctor_pov: Node2D = $doctor_pov
@onready var doctor_anim: AnimatedSprite2D = $patient_pov/doctor_anim
@onready var patient_pov: Node2D = $patient_pov
@onready var patient_anim: AnimatedSprite2D = $doctor_pov/patient_anim
@onready var animation_player: AnimationPlayer = $transition/AnimationPlayer
@onready var red_button: Area2D = $red_button
@onready var door_button: Button = $"doctor_pov/Door Button"
@onready var door_knock: AnimatedSprite2D = $doctor_pov/DoorKnock

var hasCanvasLayer = false

func _ready() -> void: 
	animation_player.play_backwards("close")
	randomize()
	MedicineManager.randomise_encounters()
	Manager.register_doctor(doctor_pov,doctor_anim)
	Manager.register_patient(patient_pov,patient_anim)
	Manager.register_computer(choose_medicine_view)
	computer_area.mouse_entered.connect(Manager._on_computer_area_mouse_entered)
	computer_area.mouse_exited.connect(Manager._on_computer_area_mouse_exited)

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	Manager.start_dialog_1(MedicineManager.get_current_patient_label())

func _on_red_button_mouse_entered() -> void:
	Manager.red_button_flag = true

func _on_red_button_mouse_exited() -> void:
	Manager.red_button_flag = false


func _on_patient_anim_animation_finished() -> void:
	if patient_anim.animation.ends_with("exit"):
		if ScoreManager.has_seen_all_patients():
			get_tree().change_scene_to_file("res://scenes/results_screen.tscn")
		else:
			door_button.disabled = false
			door_knock.show()
		patient_anim.scale.x = -1

func _on_door_button_pressed() -> void:
	door_knock.hide()
	MedicineManager.current_patient+=1
	Manager.start_dialog_1(MedicineManager.get_current_patient_label())
