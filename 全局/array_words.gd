extends Node

signal json_loaded(data)

var current_iexicon :String
#var thread :Thread = Thread.new()
var array_words :Array
var all_index_array: Array[int]
var already_words_index: Array
var word_index_range: Array[int]


var Iexicon:Dictionary[String,String] = {
	"初中":"res://Json/1-初中-顺序.json",
	"高中":"res://Json/2-高中-顺序.json",
	"CET-4":"res://Json/3-CET4-顺序.json",
	"CET-6":"res://Json/4-CET6-顺序.json",
	"考研":"res://Json/5-考研-顺序.json",
	"托福":"res://Json/6-托福-顺序.json",
	"SAT":"res://Json/7-SAT-顺序.json"
}


func _ready() -> void:
	json_loaded.connect(_set_json_loaded)
	current_iexicon = "CET-4"
	_load_json_async(Iexicon[current_iexicon])
	word_index_range = all_index_array

#
#func _exit_tree() -> void:
	#thread.wait_to_finish()

## 暴露 请求一个单词字典
func request_a_word_dir() -> Dictionary:
	if not array_words:
		return {}
	var index :int = randi_range(0,len(word_index_range)-1)
	#print("索引值%s" %index)
	var random_amount :int = word_index_range[index]
	already_words_index.append(random_amount)
	already_words_index = _unique_array(already_words_index)
	var new_words : Dictionary = array_words[random_amount]
	return new_words


## 暴露 指定返回一个单词字典
func specify_a_word_dir(index:int) -> Dictionary:
	if not array_words:
		return {}
	#print("索引值%s" %index)
	var random_amount :int = word_index_range[index]
	already_words_index.append(random_amount)
	var new_words : Dictionary = array_words[random_amount]
	return new_words

## 暴露 设置/更改字典
func set_current_iexicon(iexicon:String) -> void:
	if not iexicon:
		print("没有对应单词表名单")
		return
	current_iexicon = iexicon
	_load_json_async(Iexicon[current_iexicon])
	word_index_range = all_index_array

## 暴露 获取当前所以单词数量
func get_len_words_array() -> int:
	return len(array_words)

## 暴露 获取当前字典名称
func get_iexicon() -> String:
	return current_iexicon

## 暴露 设置索范围
func _set_word_index_range(array_range:Array[int]) -> void:
	word_index_range = array_range

func _set_json_loaded(data:Array) -> void:
	_set_json_data(data)
	_set_all_index_array()
	Events.json_load_completed.emit()


func _set_all_index_array() -> void:
	all_index_array.clear()
	for i in range(get_len_words_array()):
		all_index_array.append(i)

# 数组去重
func _unique_array(arr: Array) -> Array:
	var dict:Dictionary = {}
	for item in arr:
		dict[item] = true
	return dict.keys()


func _set_json_data(data:Array) -> void:
	array_words = data


#(多线程)加载
func _load_json_async(path: String) -> void:
	_thread_load_json(path)
	#thread.start(_thread_load_json.bind(path))

func _thread_load_json(path: String) -> void:
	# 在(子线程)中执行加载和解析
	if not FileAccess.file_exists(path):
		call_deferred("_on_json_load_failed", "文件不存在: " + path)
		return
	
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		call_deferred("_on_json_load_failed", "打开文件失败")
		return
	
	var content := file.get_as_text()
	file.close()
	
	var json := JSON.new()
	var error := json.parse(content)
	if error != OK:
		call_deferred("_on_json_load_failed", json.get_error_message())
		return
	
	# 使用call_deferred在(主线程)发出信号
	call_deferred("emit_signal", "json_loaded", json.get_data())

func _on_json_load_failed(error: String) -> void:
	print("加载JSON失败: ", error)
