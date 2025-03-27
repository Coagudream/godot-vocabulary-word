extends Node

var SCENES :Dictionary[String,String] = {
	"main_ui":"res://UI/main.tscn",
	"world":"res://主场景/main_2d.tscn"
}


func from_old_to_new_sences(current_scenes:String,next_sences:String) -> void:
	if current_scenes == next_sences:
		return
	
	if not SCENES.has(next_sences):
		return
	
	var load_path : String = SCENES[next_sences]
	
	if not ResourceLoader.exists(load_path):
		return
	
	ResourceLoader.load_threaded_request(load_path,"",true)
	
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(load_path))
