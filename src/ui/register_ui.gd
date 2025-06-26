extends Control


@onready var username_line = $VBoxContainer/username
@onready var ip_adress_line = $VBoxContainer/ip_adress
@onready var port_line = $VBoxContainer/port

@export var connect_scene: PackedScene

func _ready() -> void:
	username_line.text = PlayerData.get_nickname()
	ip_adress_line.text = PlayerData.get_last_ip()
	port_line.text = str(PlayerData.get_last_port())

func connect_to_server():
	PlayerData.set_nickname(username_line.text)
	PlayerData.set_last_ip(ip_adress_line.text)
	PlayerData.set_last_port(int(port_line.text))
	
	var menu: Control = connect_scene.instantiate()
	get_parent().add_child(menu)
	queue_free()

func _on_connect_pressed() -> void:
	if username_line.text == "" or ip_adress_line.text == "" or port_line.text == "":
		return
	
	connect_to_server()
