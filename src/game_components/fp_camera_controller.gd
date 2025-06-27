class_name FP_CameraController extends PlayerBaseComponent

signal on_camera_switched

@export var camera:Camera3D
@export var third_person_camera:Camera3D

@export_category("Settings")
@export var normal_sensivity:float = 1.0
@export var aim_sensivity:float = 0.5
@export_category("Inputs")
@export var aim:String = ""
@export_category("Variables")
@export var current_sensivity:float = 1.0
@export var is_aiming:bool = false

@onready var _cmd_aim_sens: SD_ConsoleCommand = $aim_sens.get_command()
@onready var _cmd_sens: SD_ConsoleCommand = $sens.get_command()

func _ready() -> void:
	if !is_multiplayer_authority():
		return
	
	normal_sensivity = _cmd_sens.get_value_as_float()
	aim_sensivity = _cmd_aim_sens.get_value_as_float()
	
	
	camera.make_current()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if !enabled or !is_multiplayer_authority():
		return
	if SimusDev.console.is_visible():
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		return 

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("switch_camera"):
		camera.current = not camera.current
		third_person_camera.current = not camera.current
		on_camera_switched.emit(third_person_camera.current)
	
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


func _on_aim_sens_on_updated(command: SD_ConsoleCommand) -> void:
	aim_sensivity = _cmd_aim_sens.get_value_as_float()

func _on_sens_on_updated(command: SD_ConsoleCommand) -> void:
	normal_sensivity = _cmd_sens.get_value_as_float()
