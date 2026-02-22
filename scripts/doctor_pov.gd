extends Node2D
@onready var anim_timer: Timer = $anim_timer
@onready var doctor_hands: AnimatedSprite2D = $doctor_hands

var current_anim = "idle"

func _ready() -> void:
	anim_timer.wait_time = randi_range(2,4)
	anim_timer.start()

func _on_anim_timer_timeout() -> void:
	if current_anim == "idle":
		doctor_hands.play("writing")
		current_anim = "writing"
	else:
		doctor_hands.play("idle")
		current_anim = "idle"
	anim_timer.wait_time = randi_range(2,4)
	anim_timer.start()
