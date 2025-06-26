extends CanvasLayer

@export var start_game_ui:PackedScene

@onready var bg_texture = $bg_texture
@onready var current_ui_node = $current_ui

func _ready() -> void:
	PlayerData.players_can_connect = false
	SD_Multiplayer.get_singleton().connected_to_server.connect(client_start_lobby)

func _process(delta: float) -> void:
	bg_texture.texture.noise.offset.x += 10 * delta


func _on_start_game_button_up() -> void:
	_clear_current_ui_node()
	
	var new_start_game_ui = start_game_ui.instantiate()
	current_ui_node.add_child(new_start_game_ui)

func _on_quit_button_up() -> void:
	get_tree().quit()

func client_start_lobby():
	_on_start_game_button_up()

func _clear_current_ui_node():
	for child in current_ui_node.get_children():
		child.queue_free()

func _on_connect_button_up() -> void:
	_clear_current_ui_node()
	
	var new_register_ui = preload("res://src/ui/register_ui.tscn").instantiate()
	current_ui_node.add_child(new_register_ui)
	new_register_ui.global_position = (Vector2(get_tree().root.size) / 2) + new_register_ui.size / 2




#
