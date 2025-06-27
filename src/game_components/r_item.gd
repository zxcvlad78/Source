class_name R_Item extends Resource

enum TYPES {
	MELEE = 0,
	RANGE = 1
}

@export var name:StringName 
@export var code:String

@export_category("Settings")
@export var type:TYPES

@export_category("References")
@export var model_scene:PackedScene
