extends SD_MPSyncedPlayerData

var cfg: SD_Config = SD_Config.new()

var players_can_connect: bool = false

signal can_connect_recieved(can: bool)

func _ready() -> void:
	cfg.autosave = true
	cfg.load_config("user://playerdata.cfg")
	cfg.set_value("_init_", "init", true)
	
	
	var nick_cmd: SD_ConsoleCommand = $nickname.get_command()
	nick_cmd.updated.connect(_on_nickname_updated.bind(nick_cmd))
	nick_cmd.update_command()

func get_last_ip() -> String:
	return ($last_ip.get_command() as SD_ConsoleCommand).get_value_as_string()

func get_last_port() -> int:
	return ($last_port.get_command() as SD_ConsoleCommand).get_value_as_int()

func set_last_ip(ip: String) -> void:
	return ($last_ip.get_command() as SD_ConsoleCommand).set_value(ip)

func set_last_port(port: int) -> void:
	return ($last_port.get_command() as SD_ConsoleCommand).set_value(port)

func _on_nickname_updated(cmd: SD_ConsoleCommand) -> void:
	SD_Multiplayer.set_username(cmd.get_value_as_string())

func get_nickname() -> String:
	return SD_Multiplayer.get_username()

func set_nickname(nick: String) -> void:
	var cmd: SD_ConsoleCommand = $nickname.get_command()
	cmd.set_value(nick)

func request_player_can_connect(nick: String) -> void:
	SD_Multiplayer.sync_call_function_on_server(self, _server_request_player_can_connect, [SD_Multiplayer.get_unique_id(), nick])

func _server_request_player_can_connect(peer: int, nick: String) -> void:
	SD_Multiplayer.sync_call_function_on_peer(peer, self, _recieve_request_player_can_connect, [players_can_connect])

func _recieve_request_player_can_connect(can: bool) -> void:
	can_connect_recieved.emit(can)
