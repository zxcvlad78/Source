class_name HideNodesIfAuthority extends PlayerBaseComponent

@export var nodes:Array[Node3D] = []

func _ready() -> void:
	player.camera.on_camera_switched.connect(camera_switched)
	hide()

func hide():
	if !nodes:
		return
	
	if player.is_multiplayer_authority():
		for node in nodes:
			node.visible = false

func show():
	if !nodes:
		return
	
	if player.is_multiplayer_authority():
		for node in nodes:
			node.visible = true

func camera_switched(is_third_person:bool):
	if is_third_person: show()
	else:
		hide()








#
