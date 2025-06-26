class_name GameMap extends Control

@export var map_resource:R_GameMap
@onready var loader = $loader
@onready var map_name = $bg_rect/map_name

func _ready() -> void:
	update()

func update():
	map_name.text = map_resource.name

func _on_new_game_button_up() -> void:
	loader.initial_paths = map_resource.folders_to_load
	loader.load_resources()

func _on_loader_loading_finished() -> void:
	get_tree().change_scene_to_file(map_resource.scene_path)
