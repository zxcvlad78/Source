class_name MapContainer extends VBoxContainer

@export var map_ui_prefab:PackedScene
@export_dir var maps_folder_path:String

func _ready() -> void:
	update_list()

func update_list():
	for child in get_children():
		child.queue_free()
	
	for map in dir_contents(maps_folder_path):
		var new_map_ui = map_ui_prefab.instantiate()
		new_map_ui.map_resource = load(maps_folder_path + map)
		add_child(new_map_ui)

func dir_contents(path):
	var dir = DirAccess.open(path)
	
	var files_to_return:Array = []
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
			files_to_return.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		return null
	return files_to_return
