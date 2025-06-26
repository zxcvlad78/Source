extends Control


@onready var username_line = $username
@onready var ip_adress_line = $ip_adress
@onready var port_line = $port

var cfg:SD_Config = SD_Config.new()

func connect_to_server():
	SimusDev.multiplayerAPI.set_username(username_line.text)
	SimusDev.multiplayerAPI.create_client(ip_adress_line.text, port_line.text)

func _on_enter_button_button_up() -> void:
	if username_line.text == "" or ip_adress_line.text == "" or port_line.text == "":
		return
	
	connect_to_server()
