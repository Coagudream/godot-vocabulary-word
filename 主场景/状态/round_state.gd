class_name RoundState
extends State

signal enemy_amount_zero

enum RoundStates {English,Chinese,Blender}

var max_round:int = 20
var is_chinese_round:bool = false

@onready var enemy_manager: EnemyManager = $"../../EnemyManager"

var current_round:int

func start() -> void:
	Events.request_next_round_start.connect(next_round)
	enemy_amount_zero.connect(round_end)
	await get_tree().physics_frame
	current_round = 1
	Events.round_start.emit(current_round)
	match Run.current_round_state:
		RoundStates.English:
			is_chinese_round = Run.round_model_is_chinese
		RoundStates.Chinese:
			enemy_manager.change_enemy_position(false)
		RoundStates.Blender:
			for i in randi_range(0,Run.enemy_amount-1):
				enemy_manager.change_enemy_position()

##回合结束处理函数
func round_end() -> void:
	if is_inside_tree():
		await get_tree().create_timer(1).timeout
		Events.round_end.emit()
		current_round += 1
		next_round()

##下一个回合处理函数
func next_round() -> void:
	round_amount.text ="第%s回合:" %current_round
	if is_chinese_round and current_round%2 == 0:
		chinese_round()
	else:
		Events.round_start.emit(current_round)
		if Run.current_round_state == RoundStates.Chinese:
			enemy_manager.change_enemy_position(false)
		elif Run.current_round_state == RoundStates.Blender:
			for i in randi_range(0,Run.enemy_amount-1):
				enemy_manager.change_enemy_position()
		else:
			pass
	

##下一个中文回合处理函数
func chinese_round() -> void:
	var new_array:Array[Dictionary]
	new_array = enemy_manager.current_enemies_word_dictionary
	if not new_array:
		return
	var tween:Tween = create_tween()
	tween.tween_callback(enemy_manager.add_enemies.bind(1,false,new_array))
	tween.tween_callback(enemy_manager.clear_current_enemies_word_dictionary)
	
