extends PanelContainer


func _ready() -> void:
	hide()

func _on_button_pressed() -> void:
	ArrayWords.set_current_iexicon("初中")
	await get_tree().create_timer(0.15).timeout
	hide()


func _on_button_2_pressed() -> void:
	ArrayWords.set_current_iexicon("高中")
	await get_tree().create_timer(0.15).timeout
	hide()


func _on_button_3_pressed() -> void:
	ArrayWords.set_current_iexicon("CET-4")
	await get_tree().create_timer(0.15).timeout
	hide()


func _on_button_4_pressed() -> void:
	ArrayWords.set_current_iexicon("CET-6")
	await get_tree().create_timer(0.15).timeout
	hide()


func _on_button_5_pressed() -> void:
	ArrayWords.set_current_iexicon("考研")
	await get_tree().create_timer(0.15).timeout
	hide()


func _on_button_6_pressed() -> void:
	ArrayWords.set_current_iexicon("托福")
	await get_tree().create_timer(0.15).timeout
	hide()


func _on_button_7_pressed() -> void:
	ArrayWords.set_current_iexicon("SAT")
	await get_tree().create_timer(0.15).timeout
	hide()
