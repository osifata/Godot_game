extends Area2D
signal hit_mob
signal collected_carrot

@export var speed = 400
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0

func start(pos: Vector2) -> void:
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", false)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("mobs"):
		$AnimatedSprite2D.animation = "dead"
		emit_signal("hit_mob") 
	elif body.is_in_group("carrots"):
		$CatchSound.play()
		$AnimatedSprite2D.animation = "catch"
		emit_signal("collected_carrot")  
		body.queue_free() 
