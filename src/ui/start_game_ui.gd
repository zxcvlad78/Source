extends Control

@onready var client_block = $bg_rect2/client_block

@onready var username_line = $bg_rect/VBoxContainer/username
@onready var ip_adress_line = $"bg_rect/VBoxContainer/ip-adress"
@onready var port_line = $"bg_rect/VBoxContainer/port"

func _ready() -> void:
	client_block.visible = SimusDev.multiplayerAPI.is_client()

func _on_close_ui_button_up() -> void:
	self.hide()

func _on_source_button_button_up() -> void:
	start_lobby()

func start_lobby():
	if username_line.text == "" or ip_adress_line.text == "" or port_line.text == "":
		return
	
	SimusDev.multiplayerAPI.set_username(username_line.text)
	SD_Multiplayer.create_server(int(port_line.text))
