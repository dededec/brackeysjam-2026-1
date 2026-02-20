extends Node

var current_dialogue_resource = null
var current_dialog: String = ""
var mouse_on_computer: bool = false
var computer: Node2D = null
var current_pov: String = "patient"
var doctor: Node2D = null
var doctor_anim: AnimatedSprite2D = null
var patient: Node2D = null
var patient_anim: AnimatedSprite2D = null
var ballon: CanvasLayer = null
var extra_canvas = null

var pre_pill = null
var pill_ready = false
var red_button_flag = false

var choose_medicine_view: Node2D = null

func register_doctor(node: Node2D, doctor_anim_node: AnimatedSprite2D) -> void:
	doctor = node
	doctor_anim = doctor_anim_node
func register_patient(node: Node2D, patient_anim_node: AnimatedSprite2D) -> void:
	patient = node
	patient_anim = patient_anim_node

func register_computer(node: Node2D) -> void:
	computer = node
	computer.visible = false
	computer.set_process(false)

func _ready() -> void:
	change_pov_patient()

func _process(delta: float) -> void:
	if computer and computer.visible:
		return
	var node = get_tree().root.get_node_or_null("Consult/Ballon")
	if node and ballon == null:
		ballon = node
	if pill_ready == false and mouse_on_computer and Input.is_action_just_pressed("left_clic") and doctor.visible:
		activate_computer()
	print(pre_pill, red_button_flag, pill_ready)
	if  pre_pill and red_button_flag and Input.is_action_just_pressed("left_clic"):
		pill_ready = true
		start_dialog_2(MedicineManager.randomised_patients[MedicineManager.current_patient])
		#TODO SHOULD BE SET WHEN FINISHED ANIMATION OF CREATION OF PILL

func start_dialog_1(patient: String) -> void:
	current_dialog = patient
	current_dialogue_resource = load("res://dialogue/" + patient + "_1.dialogue")
	DialogueManager.show_dialogue_balloon(current_dialogue_resource)

func start_dialog_2(patient: String) -> void:
	current_dialogue_resource = load("res://dialogue/" + patient + "_2.dialogue")
	DialogueManager.show_dialogue_balloon(current_dialogue_resource)
	
func dialog_finished_1() -> void:
	current_dialog = ""
func dialog_finished_2() -> void:
	print("SE ACABO")
	current_dialog = ""

func change_pov_patient() -> void:
	current_pov = "patient"
	if doctor != null:
		patient.hide()
		doctor.show()

func change_pov_doctor() -> void:
	current_pov = "doctor"
	if patient != null:
		doctor.hide()
		patient.show()

func activate_computer() -> void:
	if ballon:
		ballon.hide()
	if computer != null:
		computer.visible = true
		computer.set_process(true)

func deactivate_computer() -> void:
	if computer != null:
		computer.visible = false
		computer.set_process(false)
	if ballon:
		ballon.show()

func _on_computer_area_mouse_entered() -> void:
	mouse_on_computer = true

func _on_computer_area_mouse_exited() -> void:
	mouse_on_computer = false

func talking(character: String):
	if character == "Doctor":
		patient_anim.play("idle")
		doctor_anim.play("talk")
	else:
		patient_anim.play("talk")
		doctor_anim.play("idle")

func stop_talking(character: String):
	if character == "Doctor":
		patient_anim.play("idle")
		doctor_anim.play("idle")
	else:
		patient_anim.play("idle")
		doctor_anim.play("idle")
