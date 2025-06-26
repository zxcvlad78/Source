class_name Nickname extends Label3D

func _ready() -> void:
	update()

func update():
	visible = !is_multiplayer_authority()
	text = SimusDev.multiplayerAPI.get_username()
