class_name Segmentation1
extends PanelContainer

@onready var iexicon: Label = %Iexicon
@onready var words: Label = %Words
@onready var current: Label = %Current
@onready var total_amount: SpinBox = %TotalAmount
@onready var total: Label = %Total
@onready var total_grid: GridContainer = %TotalGrid
@onready var load_button: Button = %Load

const ROUND_BUTTON = preload("res://UI/分段模式/round_button.tscn")

var current_total_words :int = 30:
	set(v):
		current_total_words = v
		current_total = ArrayWords.get_len_words_array()/current_total_words

var current_total: int:
	set(v):
		current_total = v
		total.text = "共计%s段" %(current_total+1)
		_set_round_butten(current_total)


var all_index_array :Array[int]
var is_first :bool = true

func _ready() -> void:
	#await Events.json_load_completed
	total_amount.value_changed.connect(_on_total_amount_value_changed)
	iexicon.text = "当前词库:" + ArrayWords.get_iexicon()
	words.text = "共计%s单词" %ArrayWords.get_len_words_array()
	total_amount.value = current_total_words
	total.text = "共计%s段" %(current_total+1)


func _on_total_amount_value_changed(value: float) -> void:
	current_total_words = value

func _set_round_butten(current_total:int) -> void:
	if not current_total:
		return
	load_button.disabled = true
	var tween:Tween = create_tween()
	tween.tween_callback(clear_buttons)
	tween.tween_callback(_create_button.bind(current_total))
	tween.tween_callback(reset_all_index_array)
	tween.tween_interval(0.1)
	tween.tween_callback(_reset_total_button_index_array.bind(current_total_words))
	tween.finished.connect(func():load_button.disabled = false)

func clear_buttons() -> void:
	for child in total_grid.get_children():
		child.queue_free()

func _create_button(current_total:int) -> void:
	
	for child in range(1,current_total+2):
		var new_total = ROUND_BUTTON.instantiate()
		new_total.text = "%s" %child
		total_grid.add_child(new_total)

func reset_all_index_array() -> void:
	all_index_array.clear()
	all_index_array = ArrayWords.all_index_array.duplicate()
	all_index_array.shuffle()
	is_first = true

func _reset_total_button_index_array(current_total_words:int) -> void:
	for child:TotalButton in total_grid.get_children():
		child.array_index.clear()
		child.array_index = set_a_total_in_words(current_total_words)


func set_a_total_in_words(amount:int) -> Array[int]:
	if is_first:
		is_first = false
		return all_index_array.slice(0,amount)
		
	if all_index_array.size() <= amount:
		
		return all_index_array
	
	for i in range(amount):
		all_index_array.remove_at(0)
		
	return all_index_array.slice(0,amount)



func _on_load_pressed() -> void:
	save_button_data()

func save_button_data() -> void:
	var scene_data :Resource = SceneData.new()
	
	scene_data.iexicon = iexicon.text
	scene_data.words = words.text
	scene_data.current = current.text
	scene_data.total_amount = total_amount.value
	scene_data.total = total.text
	scene_data.current_iexicon = ArrayWords.get_iexicon()
	
	for child_button:TotalButton in total_grid.get_children():
		var new_save_data := PackedScene.new()
		new_save_data.pack(child_button)
		scene_data.need_save_scene_button.append(new_save_data)
	
	var errror = ResourceSaver.save(scene_data,"user://scene_data.tres")
	if errror != OK:
		print("保存出错")
		return
	print("保存OK!")
