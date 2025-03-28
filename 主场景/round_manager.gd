class_name RoundManager
extends Node

@onready var round_amount: Label = %RoundAmount

@export var is_endless:bool = false

var max_round:int = 20

var current_round:int = 1:
	set(v):
		current_round = v
		Events.round_start.emit(current_round)
		if current_round == max_round and not is_endless:
			print("游戏胜利")

var current_round_amount:float :
	set(v):
		current_round_amount = v
		if current_round_amount <= 0:
			round_end()


func _ready() -> void:
	Events.updata_enemy_amount.connect(current_amount)
	Events.request_next_round_start.connect(next_round)
	await get_tree().create_timer(0.5).timeout
	first_round_start()

func _physics_process(delta: float) -> void:
	round_amount.text ="第%s回合" %current_round + ":%s" %int(current_round_amount)

func current_amount(current_amount:int) -> void:
	current_round_amount = current_amount

##游戏第一次开始函数
func first_round_start() -> void:
	Events.round_start.emit(current_round)

##回合结束处理函数
func round_end() -> void:
	Events.round_end.emit()

##下一个回合处理函数
func next_round() -> void:
	current_round += 1
