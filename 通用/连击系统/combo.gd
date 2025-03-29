extends TextureProgressBar

@onready var label: Label = $Label

@export var max_combo :int = 100
@export var signl_combo_time:float = 5

var _current_combo :int:
	set(v):
		_current_combo = clampi(v,0,max_combo)
		label.text = "x%s" %_current_combo
		_current_combo_time = signl_combo_time
		show()
		if _current_combo == 0:
			hide()


var _current_combo_time:float:
	set(v):
		_current_combo_time = v
		value = _ramp(_current_combo_time,signl_combo_time)
		if _current_combo_time <= 0:
			_current_combo = 0

func _ready() -> void:
	label.text = ""
	_current_combo = 0
	Events.enemy_died.connect(add_combo)

func _process(_delta: float) -> void:
	if _current_combo == 0:
		value = 0
		return

func _physics_process(delta: float) -> void:
	_current_combo_time -= delta

func _ramp(input_value:float,max_input_value:float) -> float:
	var ramp_ratio:float = input_value/max_input_value
	return  max_value*ramp_ratio


func add_combo(_enemy_word:String,_enemy_translate:Array[String]) -> void:
	_current_combo += 1
