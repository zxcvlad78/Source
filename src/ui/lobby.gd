extends Control

@onready var container = $ScrollContainer/VBoxContainer

var _players: Dictionary[int, Node] = {}

func _ready() -> void:
	SimusDev.multiplayerAPI.player_connected.connect(_on_player_connected)
	SimusDev.multiplayerAPI.player_disconnected.connect(_on_player_disconnected)
	for player in SimusDev.multiplayerAPI.get_connected_players():
		_on_player_connected(player)

func _on_player_connected(player:SD_MultiplayerPlayer):
	var new_label = Label.new()
	new_label.label_settings = preload("res://resources/label_settings/default.tres")
	new_label.text = player.get_username()
	if player.is_host(): new_label.text += " (host)"
	_players[player.get_peer_id()] = new_label
	container.add_child(new_label)

func _on_player_disconnected(player: SD_MultiplayerPlayer):
	if player.get_peer_id() in _players:
		var node: Node = _players[player.get_peer_id()]
		if node: node.queue_free()
		_players.erase(player.get_peer_id())
