extends CharacterBody2D


@export var climbing = false

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
@onready var move = $AnimatedSprite2D
var health = 100
var coins = 0
var on_ladder = false




func _physics_process(delta: float) -> void:

	if not is_on_floor():
		if on_ladder==false:
			velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			move.play("jump")
	
	if on_ladder == true:
		if Input.is_action_pressed("move_up"):
			velocity.y = -SPEED*delta*10
			move.play("duck")
		elif Input.is_action_pressed("move_down"):
			velocity.y = SPEED*delta*10
			move.play("duck")
		else:
			velocity.y = 0
	else:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			if velocity.y == 0:
				move.play("walk")
				move.flip_h = velocity.x < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				move.play("stand")
	
	
	if health <= 0:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/menu.tscn")
	if position.y > 650:
		$AudioStreamPlayer.play()
		queue_free()
		get_tree().change_scene_to_file("res://scenes/main.tscn")

	move_and_slide()


func _on_ladder_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		on_ladder = true
			



func _on_ladder_body_exited(body: Node2D) -> void:
	if "Player" in body.name:
		on_ladder = false


func _on_door_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		queue_free()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/end.tscn")
