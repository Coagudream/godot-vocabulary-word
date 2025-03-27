class_name Enemy
extends CharacterBody2D

@onready var word_text: Label = %word
@onready var translation: Label = %translation
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Group/Sprite2D


@export var corrected_value:float
@export var speed :float

var _enemy_word :String:
	set(v):
		_enemy_word = v
		if not is_node_ready():
			await ready
		
		word_text.text = _enemy_word

var _enemy_translate :Array[String]:
	set(v):
		_enemy_translate = v
		if not is_node_ready():
			await ready
		for translatione:String in _enemy_translate:
			translation.text += translatione
		
		print(translation.text)


func _ready() -> void:
	corrected_value = randf_range(0.5,2.0)

func _physics_process(delta: float) -> void:
	move_and_slide()
	_move(delta)

func _move(delta: float) -> void:
	velocity = (get_viewport_rect().get_center() - global_position ).normalized()* speed * corrected_value


func set_enemy_word_and_translation() -> void:
	var word_dic = ArrayWords.request_a_word_dir()
	var word :String = word_dic["word"]
	_enemy_word = word
	
	var translations : Array = word_dic["translations"]
	var array_translations :Array[String]
	for translation in translations:
		var enemy_translation:String = translation["translation"] +","+ translation["type"]
		array_translations.append(enemy_translation)
	_enemy_translate = array_translations


func show_translation() -> void:
	translation.show()
	collision_shape_2d.set_deferred("disabled",true)
	sprite_2d.self_modulate = Color(1.0,1.0,1.0,0.0)
	var tween:Tween = create_tween()
	tween.parallel().tween_property(translation,"self_modulate",Color(1.0,1.0,1.0,0.0),3)
	tween.parallel().tween_property(word_text,"self_modulate",Color(1.0,1.0,1.0,0.0),3)
	tween.finished.connect(
		queue_free
	)

func die() -> void:
	show_translation()
