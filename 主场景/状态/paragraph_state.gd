class_name ParagraphState
extends State

func start() -> void:
	round_amount.text ="剩余单词:"
	await get_tree().physics_frame
	Events.round_start.emit(1)
