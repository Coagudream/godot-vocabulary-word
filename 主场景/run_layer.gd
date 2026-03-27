extends CanvasLayer


func _on_button_pressed() -> void:
	Events.kill_all_enemy_died.emit()
	#change_enemy_position()
	
