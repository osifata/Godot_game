extends Node

@onready var hp1 = $Heart
@onready var hp2 = $Heart2
@onready var hp3 = $Heart3

func _process(delta: float) -> void:
	var value = $"../../Player".health
	if value <=70 and value > 50:
		hp3.visible = false
	if value <=50:
		hp2.visible = false
	if value <= 0:
		hp1.visible = false
