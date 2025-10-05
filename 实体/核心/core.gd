extends StaticBody2D

@onready var word: LineEdit = $Word

@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	Events.request_cream_shakered.connect(request_cream_shaker)
	await get_tree().create_timer(0.5).timeout
	Events.care_global_position.emit(self.global_position)

func _on_word_text_submitted(new_text: String) -> void:
	if not new_text:
		return
	Events.player_input.emit(new_text)
	request_cream_shaker(20)
	word.text = ""

func request_cream_shaker(amplitude:int) -> void:
	var shaeker:= Sharker.new()
	shaeker.sharker(camera_2d,amplitude)
