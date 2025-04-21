class_name EnemyManager
extends Node2D

const ENEMY = preload("res://实体/敌人/enemy.tscn")

var index :int = 0

var current_enemies_word_dictionary: Array[Dictionary] #手动管理释放

func _ready() -> void:
	await get_tree().create_timer(0).timeout
	Events.player_input.connect(find_enemy_word_and_remove)
	Events.round_start.connect(add_enemies)
	child_order_changed.connect(updata_child_enemy)
	updata_child_enemy()

##添加一群敌人
func add_enemies(current_round:int,is_random:bool = true,arr_index:Array[Dictionary]=[]) -> void:
	var enemies_amount :int = Run.enemy_amount
	if is_random:
		for i in range(enemies_amount):
			add_random_enemy()
	else:
		if arr_index == []:
			print("没有指定敌人单词数组")
			return
		for i in arr_index:
			add_specify_enemy(i)

## 添加一个敌人(随机单词翻译)
func add_random_enemy() -> void:
	var new_enemy := ENEMY.instantiate()
	new_enemy.set_enemy_word_and_translation()
	new_enemy.global_position = random_position()
	add_child(new_enemy)
	current_enemies_word_dictionary.append(new_enemy.current_word_dictionary)
	

## 添加一个敌人(指定单词翻译)
func add_specify_enemy(word_dictionary:Dictionary) ->void:
	var new_enemy := ENEMY.instantiate()
	new_enemy.specify_enemy_word_and_translation(word_dictionary)
	new_enemy.global_position = random_position()
	add_child(new_enemy)
	new_enemy.switch_word_or_translation()

## 移除全部敌人
func find_enemy_word_and_remove(new_text:String) -> void:
	if not new_text:
		return
	for enemy:Enemy in get_children():
		if enemy._enemy_word == new_text:
			enemy.die()

## 改变敌人标签
func change_enemy_position(random:bool = true) -> void:
	if random:
		if get_child_count() == 0:
			return
		if index == get_children().size():
			index = 0
		get_children()[index].switch_word_or_translation()
		index += 1
		if index == get_children().size():
			index = 0
		return
	else:
		for child:Enemy in get_children():
			child.switch_word_or_translation()

## 清理当前敌人单词(手动管理释放)
func clear_current_enemies_word_dictionary() -> void:
	current_enemies_word_dictionary.clear()

## 敌人生成坐标
func random_position() -> Vector2:
	var viewport_rect:Rect2 = get_viewport_rect()
	var random:int = randi_range(0,3)
	if 0 == random:
		var right_add_position = Vector2(viewport_rect.position.x - 50,randf_range(viewport_rect.position.x,viewport_rect.end.y))
		return right_add_position
	elif 1 == random:
		var up_add_position = Vector2(randf_range(viewport_rect.position.x,viewport_rect.end.x),viewport_rect.position.y + 50)
		return up_add_position
	elif 2 == random:
		var down_add_position = Vector2(randf_range(viewport_rect.position.x,viewport_rect.end.x),viewport_rect.end.y + 50)
		return down_add_position
	else:
		var left_add_position = Vector2(viewport_rect.end.x + 50,randf_range(viewport_rect.position.y,viewport_rect.end.y))
		return left_add_position


##更新子节点（敌人）的数量
func updata_child_enemy() -> void:
	var child_amount:int = get_child_count()
	#print(child_amount)
	Events.updata_enemy_amount.emit(child_amount)


##暂时（按下ctrl）刷新敌人
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("add_enemy"):
		for enemy:Enemy in get_children():
			enemy.die()
		#for i in range(5):
			#add_random_enemy()

func _on_button_pressed() -> void:
	Events.request_next_round_start.emit()
	#change_enemy_position()
