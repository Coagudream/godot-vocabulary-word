extends Node

var array_words :Array

func _ready() -> void:
	await get_tree().create_timer(0).timeout
	array_words = _load_json_file("res://Json/3-CET4-顺序.json")

func request_a_word_dir() -> Dictionary:
	var random_amount :int = randi_range(0,len(array_words)-1)
	var new_words : Dictionary = array_words[random_amount]
	return new_words

# TODO 可以优化多线程加载文件
func _load_json_file(path: String) -> Array:
	# 检查文件是否存在
	if not FileAccess.file_exists(path):
		print("文件不存在: ", path)
		return []
	
	# 打开文件
	var file :FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		print("打开文件失败: ", FileAccess.get_open_error())
		return []
	
	# 读取文件内容
	var content :String= file.get_as_text()
	file.close()
	
	# 解析JSON
	var json :JSON = JSON.new()
	var parse_result :Error = json.parse(content)
	if parse_result != OK:
		print("JSON解析错误: ", json.get_error_message(), " 在行: ", json.get_error_line())
		return []
	
	var json_data = json.get_data() as Array
	
	Events.json_load_completed.emit()
	return json_data 
	
