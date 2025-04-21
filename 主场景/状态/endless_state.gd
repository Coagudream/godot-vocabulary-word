class_name EndlessState
extends State

@onready var enemy_manager: EnemyManager = $"../../EnemyManager"

var create_time:float = 2.0:
	set(v):
		create_time = v
		if enemy_manager.get_child_count() == Run.endless_state_max_enemies_amount:
			return
		
		if create_time <= 0:
			enemy_manager.add_enemies(1)
			if Run.endless_state_chinese :
				if 1 == randi_range(0,5):
					enemy_manager.change_enemy_position()
			create_time = Run.endless_state_create_enemies_time
		

func start() -> void:
	round_amount.visible = false
	await get_tree().physics_frame
	#Events.round_start.emit(1)
	Run.enemy_amount = 1
	enemy_manager.add_enemies(1)

func _physics_process(delta: float) -> void:
	if not Run.current_model == ModeStaeManager.StateS.Endless:
		return
	
	create_time -= delta
