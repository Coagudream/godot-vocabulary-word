extends Control

@onready var paragraph: Button = %Paragraph
@onready var round: Button = %Round
@onready var endless: Button = %Endless
@onready var segmentation: Segmentation1 = %Segmentation


func _on_paragraph_pressed() -> void:
	segmentation.show()


func _on_round_pressed() -> void:
	print("等待完成")


func _on_endless_pressed() -> void:
	print("等待完成")


func _on_back_pressed() -> void:
	SceneSystem.from_old_to_new_sences("model_select","main_ui")
