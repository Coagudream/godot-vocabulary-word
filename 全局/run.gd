extends Node

@export var current_model:ModeStaeManager.StateS

@export var enemy_amount:int = 5

@export var round_model_is_chinese:bool = false

var current_round_state:RoundState.RoundStates

var endless_state_max_enemies_amount :int = 4
var endless_state_create_enemies_time :float = 2.0
var endless_state_chinese:bool
