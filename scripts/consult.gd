extends Node2D

@onready var pov: AnimatedSprite2D = $pov
@onready var computer_area: Area2D = $computer_area
@onready var choose_medicine_view: Node2D = $ChooseMedicineView

func _ready() -> void: 
	Manager.register_pov(pov)
	Manager.register_computer(choose_medicine_view)
	computer_area.mouse_entered.connect(Manager._on_computer_area_mouse_entered)
	computer_area.mouse_exited.connect(Manager._on_computer_area_mouse_exited)
