extends PanelContainer

@onready var iexicon: Label = %Iexicon
@onready var words: Label = %Words
@onready var current: Label = %Current
@onready var total_amount: SpinBox = %TotalAmount
@onready var total: Label = %Total
@onready var total_grid: GridContainer = %TotalGrid
@onready var segmentation_model: PanelContainer = %SegmentationModel

func _on_paragraph_pressed() -> void:
	await get_tree().create_timer(0.02).timeout
	segmentation_model.show()
	Run.current_model = ModeStaeManager.StateS.Paragraph


func _on_round_pressed() -> void:
	await get_tree().create_timer(0.02).timeout
	Run.current_model = ModeStaeManager.StateS.Paragraph


func _on_endless_pressed() -> void:
	await get_tree().create_timer(0.02).timeout
	Run.current_model = ModeStaeManager.StateS.Paragraph


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
	ArrayWords.set_current_iexicon(data.current_iexicon)
	words.text = data.words
	current.text = data.current
	total_amount.value = data.total_amount
	total.text = data.total
	
	for child_button in data.need_save_scene_button:
		var button = child_button.instantiate()
		total_grid.add_child(button)



func _on_back_pressed() -> void:
		SceneSystem.from_old_to_new_sences("load_scene","main_ui")
