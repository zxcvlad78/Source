class_name PlayerBaseComponent extends Node

@export var enabled:bool = true
@export var player:FP_Player

func _ready() -> void:
	if !player:
		player = get_parent()
