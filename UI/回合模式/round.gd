extends PanelContainer

@onready var word_spin_box: SpinBox = %WordSpinBox
@onready var word_check_box: CheckBox = %WordCheckBox
@onready var chinese_spin_box: SpinBox = %ChineseSpinBox
@onready var blender_spin_box: SpinBox = %BlenderSpinBox


func _on_word_button_pressed() -> void:
	Run.enemy_amount = word_spin_box.value
	Run.current_round_state = RoundState.RoundStates.English
	SceneSystem.from_old_to_new_sences("model_select","world")


func _on_word_check_box_toggled(toggled_on: bool) -> void:
	Run.round_model_is_chinese = toggled_on



func _on_chinese_button_pressed() -> void:
	Run.enemy_amount = chinese_spin_box.value
	Run.current_round_state = RoundState.RoundStates.Chinese
	SceneSystem.from_old_to_new_sences("model_select","world")



func _on_blender_button_pressed() -> void:
	Run.enemy_amount = blender_spin_box.value
	Run.current_round_state = RoundState.RoundStates.Blender
	SceneSystem.from_old_to_new_sences("model_select","world")
