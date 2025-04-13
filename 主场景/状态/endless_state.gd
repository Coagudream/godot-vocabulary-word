extends State

func start() -> void:
	round_amount.text ="剩余单词:"
	Events.round_start.emit(1)
