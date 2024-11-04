extends Node

@export var mob_scene: PackedScene
@export var carrot_scene: PackedScene
var score = 0

func _ready() -> void:
	$Player.connect("hit_mob", Callable(self, "_on_player_hit_mob"))
	$Player.connect("collected_carrot", Callable(self, "_on_collected_carrot"))

func new_game():
	$StartTimer.start()
	$HUD.show_message("Приготовься!\n лови морковки")
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("carrots", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	$Music.play()

func game_over() -> void:
	$MobTimer.stop()
	$CarrotTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func _on_start_timer_timeout() -> void:
	$CarrotTimer.start()
	$MobTimer.start()

func _on_player_hit_mob() -> void:
	game_over()

func _on_collected_carrot() -> void:
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func _on_carrot_timer_timeout() -> void:
	var carrot = carrot_scene.instantiate()
	var carrot_spawn_location = $CarrotPath/CarrotSpawnLocation
	carrot_spawn_location.progress_ratio = randf()
	var direction = carrot_spawn_location.rotation + PI / 2
	carrot.position = carrot_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	carrot.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	carrot.linear_velocity = velocity.rotated(direction)
	add_child(carrot)
