extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over() -> void:
	show_message("Конец игры")
	await $MessageTimer.timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	emit_signal("start_game")

func _on_message_timer_timeout() -> void:
	$Message.hide()
