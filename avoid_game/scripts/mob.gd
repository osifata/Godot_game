extends RigidBody2D

func _ready() -> void:
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
