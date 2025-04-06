extends PanelContainer

@onready var iexicon: Label = %Iexicon
@onready var words: Label = %Words
@onready var current: Label = %Current
@onready var total_amount: SpinBox = %TotalAmount
@onready var total: Label = %Total
@onready var total_grid: GridContainer = %TotalGrid


func _ready() -> void:
	for child in total_grid.get_children():
		if not child:
			return
		child.queue_free()
	await get_tree().create_timer(0.1).timeout
	if ResourceLoader.exists("user://scene_data.tres"):
		_load()
	else:
		print("没有找到对应的存档")
	

func _load() -> void:
	var data = ResourceLoader.load("user://scene_data.tres") as SceneData
	
	iexicon.text = data.iexicon
	words.text = data.words
	current.text = data.current
	total_amount.value = data.total_amount
	total.text = data.total
	
	for child_button in data.need_save_scene_button:
		var button = child_button.instantiate()
		total_grid.add_child(button)



func _on_back_pressed() -> void:
		SceneSystem.from_old_to_new_sences("load_scene","main_ui")
