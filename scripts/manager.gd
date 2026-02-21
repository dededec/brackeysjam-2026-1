extends Node

var current_dialog: String = ""
var mouse_on_computer: bool = false
var computer: Node2D = null
var current_pov: String = "patient"
var doctor: Node2D = null
var doctor_anim: AnimatedSprite2D = null
var patient: Node2D = null
var patient_anim: AnimatedSprite2D = null
var ballon: Node2D = null
var extra_canvas = null
var first_dialog_ended: bool = false

var pre_pill = null
var pill_ready = false
var red_button_flag = false

var talking_sound_player: AudioStreamPlayer2D = null
const how_many_talking_sounds = {
	"patient_1": 3,
	"patient_2": 3,
	"patient_3": 3,
	"patient_4": 3,
	"patient_5": 4,
	"patient_6": 2,
}

var letters_displayed = 0

func register_talking_player(player: AudioStreamPlayer2D) -> void:
	talking_sound_player = player
	
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

func _process(_delta: float) -> void:
	if computer and computer.visible:
		return
	var node = get_tree().root.get_node_or_null("Consult/Balloons")
	if node and ballon == null:
		ballon = node
	if pill_ready == false and mouse_on_computer and Input.is_action_just_pressed("left_clic") and doctor.visible:
		activate_computer()
	if  pre_pill and red_button_flag and first_dialog_ended and Input.is_action_just_pressed("left_clic"):
		pill_ready = true
		start_dialog_2(MedicineManager.randomised_patients[MedicineManager.current_patient])
		#TODO SHOULD BE SET WHEN FINISHED ANIMATION OF CREATION OF PILL

func reset() -> void:
	pill_ready = false
	pre_pill = []
	first_dialog_ended = false
	computer.reset()

func start_dialog_1(patient: String) -> void:
	reset()
	current_dialog = patient
	ballon.start_dialog("res://dialogue/" + patient + "_1.dialogue")

func start_dialog_2(patient: String) -> void:
	first_dialog_ended = false
	ScoreManager.heal_patient(pre_pill)
	ballon.start_dialog("res://dialogue/" + patient + "_2.dialogue")
	
func dialog_finished_1() -> void:
	current_dialog = ""
	first_dialog_ended = true
	
func dialog_finished_2() -> void:
	current_dialog = ""
	play_patient_anim("exit")
	patient_anim.scale.x = 1

	
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
		ballon.hide_all()
	if computer != null:
		computer.visible = true
		computer.set_process(true)

func deactivate_computer() -> void:
	if computer != null:
		computer.visible = false
		computer.set_process(false)
	if ballon:
		ballon.show_all()

func _on_computer_area_mouse_entered() -> void:
	mouse_on_computer = true

func _on_computer_area_mouse_exited() -> void:
	mouse_on_computer = false

func talking(character: String):
	if character == "Doctor":
		play_patient_anim("idle")
		doctor_anim.play("talk")
	else:
		play_patient_anim("talk")
		doctor_anim.play("idle")

func stop_talking():
	play_patient_anim("idle")
	doctor_anim.play("idle")

func play_patient_anim(animation: String) -> void:
	var current_patient = MedicineManager.get_current_patient_label()
	patient_anim.play(current_patient + "_" + animation)

func play_talking_sound() -> void:
	if not talking_sound_player:
		pass
		
	if current_pov == "doctor":
		pass
	else:
		letters_displayed += 1
		if letters_displayed % 2 == 0:
			var current_patient = MedicineManager.get_current_patient_label()
			var talking_index = (randi() % how_many_talking_sounds[current_patient]) + 1
			var sound = "res://assets/sounds/" + current_patient + "_talking_" + str(talking_index) + ".wav"
			talking_sound_player.stream = load(sound)
			talking_sound_player.play()
