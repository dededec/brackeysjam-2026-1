extends Node2D

var current_dialog = null
@onready var pov: AnimatedSprite2D = $pov

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		start_dialog()

func start_dialog():
	if current_dialog == null:
		current_dialog = "test"
		DialogueManager.show_dialogue_balloon(load("res://dialogue/test_dialog.dialogue"))

func dialog_finished():
	print(current_dialog)
	current_dialog = null
	
func change_pov_patient():
	if pov != null:
		pov.play("idle_patient")

func change_pov_doctor():
	if pov != null:
		pov.play("idle_doctor")
