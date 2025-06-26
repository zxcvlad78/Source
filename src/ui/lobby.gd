extends Control

@onready var container = $ScrollContainer/VBoxContainer

func _ready() -> void:
	SimusDev.multiplayerAPI.player_connected.connect(_on_player_connected)
	for player in SimusDev.multiplayerAPI.get_connected_players():
		_on_player_connected(player)

func _on_player_connected(player:SD_MultiplayerPlayer):
	var new_label = Label.new()
	new_label.label_settings = preload("res://resources/label_settings/default.tres")
	new_label.text = player.get_username()
	if player.is_host(): new_label.text += " (host)"
	container.add_child(new_label)
