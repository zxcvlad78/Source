extends Control

@export var start_game_ui:PackedScene

@onready var bg_texture = $bg_texture
@onready var current_ui_node = $current_ui

func _ready() -> void:
	EventBus.connected_to_server.connect(client_start_lobby)

func _process(delta: float) -> void:
	bg_texture.texture.noise.offset.x += 10 * delta


func _on_start_game_button_up() -> void:
	for child in current_ui_node.get_children():
		child.queue_free()
	
	var new_start_game_ui = start_game_ui.instantiate()
	current_ui_node.add_child(new_start_game_ui)

func _on_quit_button_up() -> void:
	get_tree().quit()

func client_start_lobby():
	pass
