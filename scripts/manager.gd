extends Node

# ================================
# STATE VARIABLES
# ================================
var current_dialogue_resource = null
var current_dialog: String = ""
var mouse_on_computer: bool = false
var computer: Node2D = null
var current_pov: String = "patient"
var pov: AnimatedSprite2D = null
var ballon: CanvasLayer = null
var extra_canvas = null

# ================================
# REGISTER FUNCTIONS
# ================================
func register_pov(node: AnimatedSprite2D) -> void:
	pov = node

func register_computer(node: Node2D) -> void:
	computer = node
	computer.visible = false
	computer.set_process(false)


# ================================
# PROCESS LOOP
# ================================
func _process(delta: float) -> void:
	# Ignore dialogue input while computer is active
	if computer and computer.visible:
		return
		
	var node = get_tree().root.get_node_or_null("Consult/Ballon")
	if node and ballon == null:
		ballon = node
		ballon.hide()
		extra_canvas = get_tree().root.get_node_or_null("Consult/@CanvasLayer@11")
		
	# Start dialogue when space is pressed
	if mouse_on_computer == false and Input.is_action_just_pressed("space"):
		start_dialog()

	# Debug: print current POV and mouse state
	if Input.is_action_just_pressed("left_clic"):
		print("Current POV:", current_pov, "Mouse on computer:", mouse_on_computer)

	# Activate computer when clicking on it with doctor POV
	if mouse_on_computer and Input.is_action_just_pressed("left_clic") and current_pov == "doctor":
		activate_computer()


# ================================
# DIALOGUE FUNCTIONS
# ================================
func start_dialog() -> void:
	if current_dialog == "":
		current_dialog = "test"
		current_dialogue_resource = load("res://dialogue/test_dialog.dialogue")
		DialogueManager.show_dialogue_balloon(current_dialogue_resource)


func dialog_finished() -> void:
	current_dialog = ""


# ================================
# POV SWITCHING
# ================================
func change_pov_patient() -> void:
	current_pov = "patient"
	if pov != null:
		pov.play("idle_patient")


func change_pov_doctor() -> void:
	current_pov = "doctor"
	if pov != null:
		pov.play("idle_doctor")


# ================================
# COMPUTER UI FUNCTIONS
# ================================
func activate_computer() -> void:
	extra_canvas.hide()
	print("BALLOOON", ballon.visible)

	# Show computer UI
	if computer != null:
		computer.visible = true
		computer.set_process(true)


func deactivate_computer() -> void:
	# Hide computer UI
	if computer != null:
		computer.visible = false
		computer.set_process(false)

	# Resume dialogue balloon
	if DialogueManager.current_balloon != null:
		DialogueManager.current_balloon.visible = true


# ================================
# MOUSE AREA SIGNALS
# ================================
func _on_computer_area_mouse_entered() -> void:
	mouse_on_computer = true

func _on_computer_area_mouse_exited() -> void:
	mouse_on_computer = false
