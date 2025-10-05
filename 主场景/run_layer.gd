extends CanvasLayer


func _on_button_pressed() -> void:
	Events.request_next_round_start.emit()
	#change_enemy_position()
