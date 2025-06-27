extends Node

@export var maps_path: String = "res://maps"

var _current_map: R_GameMap
var _maps: Dictionary[String, R_GameMap] = {}

signal map_recieved_from_server(map: R_GameMap)

func _ready() -> void:
	for path in SD_FileSystem.get_all_files_with_extension_from_directory(maps_path, SD_FileExtensions.EC_RESOURCE):
		var resource: Resource = load(path)
		if resource is R_GameMap:
			add_map(resource)

func get_current_map() -> R_GameMap:
	return _current_map

func set_current_map(map: R_GameMap) -> void:
	_current_map = map

func get_map_list() -> Array[R_GameMap]:
	return _maps.values() as Array[R_GameMap]

func add_map(resource: R_GameMap) -> void:
	if has_map(resource):
		return
	
	_maps[resource.code] = resource

func remove_map(resource: R_GameMap) -> void:
	if not has_map(resource):
		return
	
	_maps.erase(resource.code)

func get_map_by_code(code: String) -> R_GameMap:
	return _maps.get(code)

func has_map(resource: R_GameMap) -> bool:
	return _maps.has(resource.code)

func request_map_from_server() -> void:
	SD_Multiplayer.sync_call_function_on_server(self, _server_send_map_to_client, [SD_Multiplayer.get_unique_id()])

func _server_send_map_to_client(peer: int) -> void:
	SD_Multiplayer.sync_call_function_on_peer(peer, self, _client_recieve_map, [get_current_map()])

func _client_recieve_map(map: R_GameMap) -> void:
	map_recieved_from_server.emit(map)
