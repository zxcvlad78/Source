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
	SD_Multiplayer.create_server(port_line.text)
