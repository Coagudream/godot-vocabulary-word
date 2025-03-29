extends Control

@onready var menu: VBoxContainer = $PanelContainer/Menu
@onready var panel_container: PanelContainer = $PanelContainer

func _on_game_stop_pressed() -> void:
	get_tree().paused = true
	panel_container.show()


#菜单
func _on_back_pressed() -> void:
	get_tree().paused = false
	panel_container.hide()


func _on_set_pressed() -> void:
	pass # Replace with function body.


func _on_statistics_pressed() -> void:
	pass # Replace with function body.


func _on_back_main_pressed() -> void:
	get_tree().paused = false
	SceneSystem.from_old_to_new_sences("world","main_ui")
