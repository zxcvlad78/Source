class_name GameMap extends Control

@export var map_resource:R_GameMap
@onready var loader = $loader
@onready var map_name = $bg_rect/map_name

func _ready() -> void:
	Maps.map_recieved_from_server.connect(_on_map_recieved_from_server)
	update()

func _on_map_recieved_from_server(map: R_GameMap) -> void:
	if map == map_resource:
		_on_new_game_button_up()

func update():
	map_name.text = map_resource.name

func _on_new_game_button_up() -> void:
	loader.initial_paths = map_resource.folders_to_load
	loader.load_resources()

func _on_loader_loading_finished() -> void:
	Maps.set_current_map(map_resource)
	get_tree().change_scene_to_file(map_resource.scene_path)
