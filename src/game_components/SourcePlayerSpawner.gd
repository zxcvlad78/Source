@icon("res://addons/simusdev/icons/MultiplayerSpawner.svg")
extends Node
class_name SourcePlayerSpawner

@export var player_scene: PackedScene
@export var parent: Node
@export var spawnpoints: Array[Node3D] = []

@onready var api: SD_MultiplayerSingleton = SD_Multiplayer.get_singleton()

func _ready() -> void:
	if not SD_Multiplayer.is_server():
		queue_free()
		return
	
	for player in api.get_connected_players():
		spawn(player)
	
	api.player_connected.connect(_on_player_connected)
	api.player_disconnected.connect(_on_player_disconnected)
	

func _on_player_connected(player: SD_MultiplayerPlayer) -> void:
	spawn(player)

func _on_player_disconnected(player: SD_MultiplayerPlayer) -> void:
	despawn(player)

func pick_spawnpoint() -> Node3D:
	return spawnpoints.pick_random()

func spawn(player: SD_MultiplayerPlayer) -> void:
	var instance: FP_Player = player_scene.instantiate()
	instance.tree_entered.connect(
		func():
			instance.name = str(player.get_peer_id())
			var point: Node3D = pick_spawnpoint()
			if point:
				instance.position = point.position
			
	)
	
	player.set_node(instance)
	parent.add_child.call_deferred(instance)

func despawn(player: SD_MultiplayerPlayer) -> void:
	var instance: Node = player.get_node()
	if instance:
		instance.queue_free()
	
