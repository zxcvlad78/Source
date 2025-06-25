class_name FP_CameraController extends PlayerBaseComponent

@export var camera:Camera3D

@export_category("Settings")
@export var normal_sensivity:float = 1.0
@export var aim_sensivity:float = 0.5
@export_category("Inputs")
@export var aim:String = ""
@export_category("Variables")
@export var current_sensivity:float = 1.0
@export var is_aiming:bool = false

func _input(event: InputEvent) -> void:
	if !enabled or !is_multiplayer_authority():
		return
	
	#aim logic
	is_aiming = Input.is_action_pressed(aim)
	if is_aiming: current_sensivity = aim_sensivity
	else:
		current_sensivity = normal_sensivity
	
	#move logic
	if event is InputEventMouseMotion:
		var rotation_x = event.relative.y # <-- !!!! x 
		var rotation_y = event.relative.x # <-- !!!! y

		camera.rotation_degrees.x -= (rotation_x * current_sensivity) * .25
		player.rotation_degrees.y -= (rotation_y * current_sensivity) * .25
