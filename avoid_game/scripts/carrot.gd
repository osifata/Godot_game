extends RigidBody2D
var score

func _ready() -> void:
	var carrot_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(carrot_types[randi() % carrot_types.size()])

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
