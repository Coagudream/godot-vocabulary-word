extends Control

@onready var changed_iexicon_panel: PanelContainer = $ChangedIexiconPanel

func _on_start_pressed() -> void:
	SceneSystem.from_old_to_new_sences("main_ui","model_select")


func _on_continue_pressed() -> void:
	SceneSystem.from_old_to_new_sences("main_ui","load_scene")


func _on_statistics_pressed() -> void:
	pass # Replace with function body.


func _on_set_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_changed_iexicon_pressed() -> void:
	if changed_iexicon_panel.visible == true:
		changed_iexicon_panel.hide()
	elif changed_iexicon_panel.visible == false:
		changed_iexicon_panel.show()
