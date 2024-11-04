extends Node2D


func quit() -> void:
	get_tree().quit()


func again() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
