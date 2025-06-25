class_name FootstepsSound extends PlayerBaseComponent

@export_group("Assets")
@export_subgroup("Grass-Like")
@export var grass:Array[AudioStream] = []
@export var gravel:Array[AudioStream] = []
@export var dirt:Array[AudioStream] = []
@export var mud:Array[AudioStream] = []
@export var sand:Array[AudioStream] = []

@export_subgroup("Stone-Like")
@export var concrete:Array[AudioStream] = []
@export var tile:Array[AudioStream] = []

@export_subgroup("Metal-Like")
@export var chainlink:Array[AudioStream] = []
@export var duct:Array[AudioStream] = []
@export var metal:Array[AudioStream] = []
@export var metalgrate:Array[AudioStream] = []

@export_subgroup("Wood-Like")
@export var wood:Array[AudioStream] = []
@export var woodpanel:Array[AudioStream] = []
@export var ladder:Array[AudioStream] = []

@export_subgroup("Water-Like")
@export var wade:Array[AudioStream] = []
@export var slosh:Array[AudioStream] = []

@export_category("Surface")
@export var current_surface:String = "grass"

@export_group("References") 
@export var audio_player:SD_MPSyncedAudioStreamPlayer3D

func _ready() -> void:
	if !audio_player:
		audio_player = SD_MPSyncedAudioStreamPlayer3D.new()
		player.add_child(audio_player)
	
	while true:
		_do_footstep()
		await get_tree().create_timer(1.0).timeout

func _do_footstep():
	if !get(current_surface):
		return
	
	randomize()
	
	var rand_idx = randi()% (get(current_surface).size() - 1)
	audio_player.stream = get(current_surface)[rand_idx]
	
	audio_player.play_synced()
