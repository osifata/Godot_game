extends CharacterBody2D

var chase = false
var ap = false
var speed = 100
@onready var move = $AnimatedSprite2D
var alive = true



func _physics_process(delta):
	var player = $"../Player"
	var dir = (player.position - self.position).normalized()
	if alive:
		if ap == true:
			if not self.visible:
				self.visible = true
				move.play("appear")
				await move.animation_finished
			if chase:
				velocity.x = dir.x * speed * 2
				velocity.y = dir.y * speed * 2
				move.play("fly")
			else:
				velocity = Vector2.ZERO
				move.play("fly")
			move.flip_h = dir.x >= 0
		else:
			if self.visible:
				move.play("disappear")
				await move.animation_finished
				self.visible = false
				
	move_and_slide()


func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false


func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true


func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AudioStreamPlayer.play()
		body.velocity.y -= 200
		death()

func _on_hit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if alive == true:
			body.health -= 40
			$"../Player".move.play("hurt")
			$AudioStreamPlayer2.play()
		death()

func death():
	alive = false
	move.play("death")
	await move.animation_finished
	queue_free()


func _on_appear_detected_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		ap = true


func _on_appear_detected_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		ap = false
		
