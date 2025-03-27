class_name RoundManager
extends Node

@onready var round_duration: Label = %RoundDuration

@export var is_endless:bool = false

var max_round:int = 20

var current_round:int = 1:
	set(v):
		current_round = v
		Events.round_start.emit(current_round)
		if current_round == max_round and not is_endless:
			print("游戏胜利")

var current_round_duration:float = 3:
	set(v):
		current_round_duration = v
		if current_round_duration <= 0:
			round_end()


func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	first_round_start()
	Events.request_next_round_start.connect(next_round)

func _physics_process(delta: float) -> void:
	current_round_duration -= delta
	round_duration.text ="第%s回合"%current_round + ":%s" %int(current_round_duration)

##游戏第一次开始函数
func first_round_start() -> void:
	Events.round_start.emit(current_round)

##回合结束处理函数
func round_end() -> void:
	Events.round_end.emit()
	get_tree().paused = true

##下一个回合处理函数
func next_round() -> void:
	get_tree().paused = false
	current_round += 1
	current_round_duration = 50*(log(current_round+3)/log(10))
