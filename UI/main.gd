extends Control

@onready var changed_iexicon_panel: PanelContainer = $ChangedIexiconPanel
@onready var thanks: PanelContainer = $Thanks
@onready var title: Label = $Title

func _ready() -> void:
	thanks.hide()
	tween_anim()

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


func _on_thank_toggled(toggled_on: bool) -> void:
	if toggled_on:
		thanks.show()
	else:
		thanks.hide()

var tween_scale:Tween

func tween_anim() -> void:
	tween_scale = create_tween().set_loops()
	tween_scale.tween_property(title,"scale",Vector2(0.98,0.98),0.5)
	tween_scale.tween_property(title,"scale",Vector2(1.05,1.05),0.5)
