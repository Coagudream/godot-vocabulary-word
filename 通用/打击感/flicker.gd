class_name Flicker
extends RefCounted


func flicker(node:Node,strength:float,amount:int=2,duration:float = 0.2) -> void:
	
	#var original_color :Color = node.modulate
	var original_color :Color = Color(1.0,1.0,1.0,1.0)
	var tween :Tween = node.create_tween()
	var color :Color = Color(0.8*strength,0.8*strength,0.8*strength,1.0)
	
	for i in amount:
		
		tween.tween_property(node,"modulate",color,duration/float(amount))
		
		tween.tween_property(node,"modulate",original_color,duration/float(amount))
		
	tween.finished.connect(func(): node.modulate = original_color)
