extends Control

@export var label: Label

var m_api: SD_MultiplayerSingleton = SD_Multiplayer.get_singleton()

func _ready() -> void:
	m_api.create_client(PlayerData.get_last_ip(), PlayerData.get_last_port())
	m_api.connected_to_server.connect(_on_connected_to_server)
	m_api.connection_failed.connect(_on_connection_failed)
	m_api.client_closed.connect(_on_client_closed)
	
	PlayerData.can_connect_recieved.connect(_on_can_connect_recieved)

func _on_connected_to_server() -> void:
	label.text = "CONNECTED TO SERVER! WAITING SERVER..."
	queue_free()
	#await get_tree().create_timer(1.5).timeout
	#$refresh.start()

func _on_connection_failed() -> void:
	label.text = "CONNECTION FAILED!"
	$Panel/cancel.hide()
	await get_tree().create_timer(1.5).timeout
	_on_cancel_pressed()

func _on_cancel_pressed() -> void:
	m_api.close_client()
	queue_free()

func _on_client_closed() -> void:
	label.text = "CONNECTION FAILED! PLAYER WITH THIS NICKNAME ALREADY ON SERVER."
	$Panel/cancel.hide()
	await get_tree().create_timer(1.5).timeout
	_on_cancel_pressed()

func _on_refresh_timeout() -> void:
	if not m_api.is_connected_to_server():
		return
	
	PlayerData.request_player_can_connect(PlayerData.get_nickname())

func _on_can_connect_recieved() -> void:
	$refresh.stop()
	label.text = "PLEASE, LOGIN."
	await get_tree().create_timer(1.5).timeout
	queue_free()
