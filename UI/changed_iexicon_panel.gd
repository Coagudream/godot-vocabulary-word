extends PanelContainer

@onready var button: Button = $MarginContainer/VBoxContainer/Button
@onready var button_2: Button = $MarginContainer/VBoxContainer/Button2
@onready var button_3: Button = $MarginContainer/VBoxContainer/Button3
@onready var button_4: Button = $MarginContainer/VBoxContainer/Button4
@onready var button_5: Button = $MarginContainer/VBoxContainer/Button5
@onready var button_6: Button = $MarginContainer/VBoxContainer/Button6
@onready var button_7: Button = $MarginContainer/VBoxContainer/Button7
@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer

var is_clicked :String :
	set(v) :
		is_clicked = v
		set_clicked(is_clicked)

func _ready() -> void:
	hide()
	is_clicked = ArrayWords.get_iexicon()

func set_clicked(button_name:String) -> void:
	for buttons in v_box_container.get_children():
		buttons.disabled = false
	match button_name:
		"初中":
			button.disabled = true
		"高中":
			button_2.disabled = true
		"CET-4":
			button_3.disabled = true
		"CET-6":
			button_4.disabled = true
		"考研":
			button_5.disabled = true
		"托福":
			button_6.disabled = true
		"SAT":
			button_7.disabled = true
		_:
			return

func _on_button_pressed() -> void:
	ArrayWords.set_current_iexicon("初中")
	is_clicked = "初中"
	_await_time()


func _on_button_2_pressed() -> void:
	ArrayWords.set_current_iexicon("高中")
	is_clicked = "高中"
	_await_time()
	


func _on_button_3_pressed() -> void:
	ArrayWords.set_current_iexicon("CET-4")
	is_clicked = "CET-4"
	_await_time()


func _on_button_4_pressed() -> void:
	ArrayWords.set_current_iexicon("CET-6")
	is_clicked = "CET-6"
	_await_time()


func _on_button_5_pressed() -> void:
	ArrayWords.set_current_iexicon("考研")
	is_clicked = "考研"
	_await_time()


func _on_button_6_pressed() -> void:
	ArrayWords.set_current_iexicon("托福")
	is_clicked = "托福"
	_await_time()


func _on_button_7_pressed() -> void:
	ArrayWords.set_current_iexicon("SAT")
	is_clicked = "SAT"
	_await_time()


func _await_time() -> void:
	#await get_tree().create_timer(0.01).timeout
	pass
