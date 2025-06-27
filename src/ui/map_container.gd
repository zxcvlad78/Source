class_name MapContainer extends VBoxContainer

@export var map_ui_prefab:PackedScene
@export_dir var maps_folder_path:String

func _ready() -> void:
	update_list()

func update_list():
	for child in get_children():
		child.queue_free()
	
	for map in Maps.get_map_list():
		var new_map_ui = map_ui_prefab.instantiate()
		new_map_ui.map_resource = map
		add_child(new_map_ui)
