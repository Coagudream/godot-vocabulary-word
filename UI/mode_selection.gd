extends Control

@onready var paragraph: Button = %Paragraph
@onready var round: Button = %Round
@onready var endless: Button = %Endless
@onready var segmentation_model: Segmentation1 = %SegmentationModel
@onready var round_model: PanelContainer = %RoundModel
@onready var endless_model: PanelContainer = %EndlessModel

func _ready() -> void:
	paragraph.button_pressed = true
	Run.current_model = ModeStaeManager.StateS.Paragraph

 
func _on_paragraph_pressed() -> void:
	endless_model.hide()
	round_model.hide()
	segmentation_model.show()
	Run.current_model = ModeStaeManager.StateS.Paragraph

func _on_round_pressed() -> void:
	segmentation_model.hide()
	endless_model.hide()
	round_model.show()
	Run.current_model = ModeStaeManager.StateS.Round

func _on_endless_pressed() -> void:
	segmentation_model.hide()
	round_model.hide()
	endless_model.show()
	Run.current_model = ModeStaeManager.StateS.Endless

func _on_back_pressed() -> void:
	SceneSystem.from_old_to_new_sences("model_select","main_ui")
