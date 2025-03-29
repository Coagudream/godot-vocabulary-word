extends Control

func _on_start_pressed() -> void:
	SceneSystem.from_old_to_new_sences("main_ui","world")


func _on_continue_pressed() -> void:
	pass # Replace with function body.


func _on_statistics_pressed() -> void:
	pass # Replace with function body.


func _on_set_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
