extends PanelContainer

@onready var word_spin_box: SpinBox = %WordSpinBox
@onready var word_time: SpinBox = %WordTime


func _on_word_check_box_toggled(toggled_on: bool) -> void:
	Run.endless_state_chinese = toggled_on


func _on_word_button_pressed() -> void:
	Run.endless_state_max_enemies_amount = word_spin_box.value
	Run.endless_state_create_enemies_time = word_time.value
	SceneSystem.from_old_to_new_sences("model_select","world")
