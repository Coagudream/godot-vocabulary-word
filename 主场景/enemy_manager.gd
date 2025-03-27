class_name EnemyManager
extends Node2D

const ENEMY = preload("res://实体/敌人/enemy.tscn")

func _ready() -> void:
	await get_tree().create_timer(0).timeout
	Events.player_input.connect(find_enemy_word_and_remove)
	for i in range(5):
		add_enemy()


func add_enemy() -> void:
	var new_enemy := ENEMY.instantiate()
	new_enemy.set_enemy_word_and_translation()
	new_enemy.global_position = random_position()
	add_child(new_enemy)

func find_enemy_word_and_remove(new_text:String) -> void:
	if not new_text:
		return
	for enemy:Enemy in get_children():
		if enemy._enemy_word == new_text:
			enemy.die()

func random_position() -> Vector2:
	var viewport_rect:Rect2 = get_viewport_rect()
	if 0 == randi_range(0,3):
		var right_add_position = Vector2(viewport_rect.position.x - 50,randf_range(viewport_rect.position.x,viewport_rect.end.y))
		return right_add_position
	elif 1 == randi_range(0,3):
		var up_add_position = Vector2(randf_range(viewport_rect.position.x,viewport_rect.end.x),viewport_rect.position.y - 50)
		return up_add_position
	elif 2 == randi_range(0,3):
		var down_add_position = Vector2(randf_range(viewport_rect.position.x,viewport_rect.end.x),viewport_rect.position.x - 50)
		return down_add_position
	else:
		var left_add_position = Vector2(viewport_rect.end.x,randf_range(viewport_rect.position.y,viewport_rect.end.y))
		return left_add_position




func _input(event: InputEvent) -> void:
	if event.is_action_pressed("add_enemy"):
		for enemy:Enemy in get_children():
			enemy.die()
	
		for i in range(5):
			add_enemy()

	
func _on_button_pressed() -> void:
	
	for enemy:Enemy in get_children():
		enemy.die()
		
	for i in range(5):
		add_enemy()
