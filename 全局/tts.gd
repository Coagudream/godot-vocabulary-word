extends Node

var voices : PackedStringArray
var voice_id :String

func _ready() -> void:
	var voices = DisplayServer.tts_get_voices_for_language("en")
	var voice_id = voices[0]

func request_tts_word(word:String) -> void:
	if not voices:
		return
	if DisplayServer.tts_is_speaking():
		DisplayServer.tts_stop()
	else:
		DisplayServer.tts_speak(word, voice_id)
