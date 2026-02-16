extends Area2D

@onready var hover_rectangle: Sprite2D = $HoverRectangle

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	hover_rectangle.visible = true

func _on_body_exited(body: Node2D) -> void:
	hover_rectangle.visible = false
