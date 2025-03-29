extends Node

#回合
signal round_start(current_round:int)  ##回合开始
signal round_end  ##回合结束
signal request_next_round_start  ##请求下一个回合开始

#文件
signal json_load_completed ##json文件加载完成

#玩家
signal player_input(word:String) ##玩家输入

#敌人
signal updata_enemy_amount(enemy_amount:int)
signal enemy_died

#摄像机震动
signal request_cream_shakered(amplitude:int)
