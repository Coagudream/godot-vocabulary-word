class_name ModeStaeManager
extends Node

enum StateS {None,Paragraph,Round,Endless}

@onready var paragraph_state: State = $ParagraphState
@onready var round_state: State = $RoundState
@onready var endless_state: State = $EndlessState
@onready var enemy_amount: Label = %EnemyAmount

@export var current_stae :StateS


var is_first_zero:bool = true #这个变量只要是因为current_round_amount变量和EnemyManager的updata_child_enemy()节点冲突

func _ready() -> void:
	Events.updata_enemy_amount.connect(updata_current_amount)
	current_stae = Run.current_model
	first_round_start(current_stae)


##游戏第一次开始函数
func first_round_start(current_stae:StateS) -> void:
	await get_tree().create_timer(0.1).timeout
	match current_stae:
		ModeStaeManager.StateS.None:
			print("状态为空")
			return
		ModeStaeManager.StateS.Paragraph:
			paragraph_state.start()
			
		ModeStaeManager.StateS.Round:
			round_state.start()
			
		ModeStaeManager.StateS.Endless:
			endless_state.start()
			

func updata_current_amount(current_amount:int) -> void:
	if current_amount == 0 and is_first_zero :
		is_first_zero = false
		return
	if enemy_amount:
		enemy_amount.text = "%s" %current_amount
	
	if (current_stae == ModeStaeManager.StateS.Round) and (current_amount == 0):
		round_state.enemy_amount_zero.emit()
