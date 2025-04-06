class_name TotalButton
extends Button

@export var array_index:Array[int]

func _on_pressed() -> void:
	#print(array_index)
	ArrayWords._set_word_index_range(array_index)
	SceneSystem.from_old_to_new_sences("model_select","world")
