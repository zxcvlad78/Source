class_name HideNodesIfAuthority extends Node

@export var target:Node
@export var nodes:Array[Node3D] = []

func _ready() -> void:
	if !nodes:
		return
	
	if target.is_multiplayer_authority():
		for node in nodes:
			node.visible = false
