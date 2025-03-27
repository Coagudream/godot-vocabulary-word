extends Node


signal round_start(current_round:int)  ##回合开始
signal round_end  ##回合结束
signal request_next_round_start  ##请求下一个回合开始


signal json_load_completed ##json文件加载完成


signal player_input(word:String) ##玩家输入


signal request_cream_shakered(amplitude:int)
