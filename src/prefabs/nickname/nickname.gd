class_name Nickname extends Label3D

@export var target: FP_Player

func _ready() -> void:
	update()

func update():
	visible = !is_multiplayer_authority()
	text = SD_MultiplayerPlayer.find_in_node(target).get_username()
