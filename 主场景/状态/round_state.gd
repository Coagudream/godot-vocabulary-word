extends State

signal enemy_amount_zero

var max_round:int = 20


var current_round:int:
	set(v):
		current_round = v
		Events.round_start.emit(current_round)
		round_amount.text ="第%s回合:" %current_round

func start() -> void:
	Events.request_next_round_start.connect(next_round)
	enemy_amount_zero.connect(round_end)
	await get_tree().physics_frame
	current_round = 1

##回合结束处理函数
func round_end() -> void:
	if is_inside_tree():
		await get_tree().create_timer(4).timeout
		Events.round_end.emit()
		get_tree().paused = true

##下一个回合处理函数
func next_round() -> void:
	current_round += 1
	get_tree().paused = false
