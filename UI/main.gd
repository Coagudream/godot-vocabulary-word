extends Control


func _on_button_pressed() -> void:
	SceneSystem.from_old_to_new_sences("main_ui","world")


func _on_button_5_pressed() -> void:
	get_tree().quit()
