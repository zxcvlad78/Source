@tool
class_name BaseItem extends Node3D

@export var item_resource:R_Item

@export var setup:bool = false : set = _setup

func _setup(value:bool):
	if !value:
		return
	
	
	
	setup = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
