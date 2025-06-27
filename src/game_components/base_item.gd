@tool
class_name BaseItem extends Node3D

@export var item_resource:R_Item
@export var setup:bool = false : set = _setup

@export_group("References")
@export var model:Node3D

func _setup(value:bool):
	if !value or !item_resource.model_scene:
		return
	
	if is_instance_valid(model):
		model.queue_free()
		model = item_resource.model_scene.instantiate()
	
	await get_tree().create_timer(0.5).timeout
	
	add_child(model)
	model.set_owner(self)
	
	setup = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
