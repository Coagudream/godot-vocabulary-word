class_name Spring2D
extends RefCounted



func spring(node:Node2D,is_fixed_aspect_ratio:bool = true,strength:float = 1,amount:int=4,duration:float = 0.4) -> void:
	
	var original_scale :Vector2 = node.scale
	var tween: Tween = node.create_tween()
	
	var reduce_scale :Vector2
	var amplify_scale :Vector2
	
	if not is_fixed_aspect_ratio:
	#非纵横比固定放大参数(默认node为1：1)
		reduce_scale  = Vector2(randf_range(1.05,1.15),randf_range(1.05,1.15))*strength
		amplify_scale  = Vector2(randf_range(0.85,0.95),randf_range(0.85,0.95))*strength
		
	
	if is_fixed_aspect_ratio:
	#按照纵横比固定放大参数(默认node为1：1)
		
		var amplify_aspect_ratio = randf_range(1.05,1.15)
		var reduce_aspect_ratio = randf_range(0.85,0.95)
		
		reduce_scale  = Vector2(reduce_aspect_ratio ,reduce_aspect_ratio )*strength
		amplify_scale  = Vector2(amplify_aspect_ratio,amplify_aspect_ratio)*strength
		
		
	for i in amount:
		tween.tween_property(node,"scale",reduce_scale,duration/float(amount))
		
		tween.tween_property(node,"scale",amplify_scale,duration/float(amount))
		
		
	
	tween.finished.connect(func(): node.scale = original_scale)
