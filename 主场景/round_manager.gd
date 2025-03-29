class_name ModeManager
extends Node

@onready var round_amount: Label = %RoundAmount

@export var is_endless:bool = false


var max_round:int = 20
var is_first_zero:bool = true #这个变量只要是因为current_round_amount变量和EnemyManager的updata_child_enemy()节点冲突
var current_round:int = 1:
	set(v):
		current_round = v
		Events.round_start.emit(current_round)

var current_round_amount:float :
	set(v):
		current_round_amount = v
		if round_amount:
			round_amount.text ="第%s回合" %current_round + ":%s" %int(current_round_amount)
		if current_round_amount <= 0:
			round_end()


func _ready() -> void:
	Events.updata_enemy_amount.connect(updata_current_amount)
	Events.request_next_round_start.connect(next_round)
	await get_tree().create_timer(0.5).timeout
	first_round_start()


func updata_current_amount(current_amount:int) -> void:
	if current_amount == 0 and is_first_zero :
		is_first_zero = false
		return
	current_round_amount = current_amount
	

##游戏第一次开始函数
func first_round_start() -> void:
	Events.round_start.emit(current_round)


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
