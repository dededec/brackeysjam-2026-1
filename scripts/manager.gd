extends Node

var current_dialogue_resource = null
var current_dialog: String = ""
var mouse_on_computer: bool = false
var computer: Node2D = null
var current_pov: String = "patient"
var doctor: Node2D = null
var patient: Node2D = null

var ballon: CanvasLayer = null
var extra_canvas = null

var choose_medicine_view: Node2D = null

func register_doctor(node: Node2D) -> void:
	doctor = node
func register_patient(node: Node2D) -> void:
	patient = node

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
		ballon.hide()
		extra_canvas = get_tree().root.get_node_or_null("Consult/@CanvasLayer@11")
		
	if mouse_on_computer == false and Input.is_action_just_pressed("space"):
		start_dialog()
	if mouse_on_computer and Input.is_action_just_pressed("left_clic") and current_pov == "doctor":
		activate_computer()

func start_dialog() -> void:
	if current_dialog == "":
		current_dialog = "test"
		current_dialogue_resource = load("res://dialogue/test_dialog.dialogue")
		DialogueManager.show_dialogue_balloon(current_dialogue_resource)

func dialog_finished() -> void:
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
	extra_canvas.hide()
	if computer != null:
		computer.visible = true
		computer.set_process(true)

func deactivate_computer() -> void:
	if computer != null:
		computer.visible = false
		computer.set_process(false)
	extra_canvas.show()

func _on_computer_area_mouse_entered() -> void:
	mouse_on_computer = true

func _on_computer_area_mouse_exited() -> void:
	mouse_on_computer = false
