class_name FP_MovementController extends PlayerBaseComponent

@export var move_speed:float = 5.0
@export var sprint_speed:float = 16.0
@export var jump_accel:float = 14.0
@export var current_speed:float = 5.0

@export_category("Input Keys")
@export var move_left:String = ""
@export var move_right:String = ""
@export var move_forward:String = ""
@export var move_backward:String = ""

@export var sprint:String = ""
@export var jump:String = ""
@export var crouch:String = ""

@export_category("Variables")
@export var input_direction:Vector2 = Vector2.ZERO
@export var direction:Vector3 = Vector3.ZERO
@export var is_sprinting:bool = false

@export_group("References")
@export var state_machine:SD_NodeStateMachine

func _ready() -> void:
	state_machine.state_enter.connect(_on_state_machine_state_enter)

func _physics_process(_delta: float) -> void:
	set_tree_blend()
	if !enabled or !is_multiplayer_authority():
		return
	input_direction = Input.get_vector(move_left, move_right, move_forward, move_backward)
	direction = player.global_transform.basis * Vector3(input_direction.x, 0., input_direction.y)
	
	if player.is_on_floor():
		if Input.is_action_just_pressed(jump):
			player.velocity.y += jump_accel
	else:
		state_machine.switch_by_name("floating")
	
	is_sprinting = Input.is_action_pressed(move_forward) and Input.is_action_pressed(sprint)
	if is_sprinting:
		current_speed = sprint_speed
		state_machine.switch_by_name("run")
	else:
		current_speed = move_speed
		state_machine.switch_by_name("walk")
	
	if !player.velocity: state_machine.switch_by_name("idle")
	
	player.velocity.x = (direction.x * current_speed)
	player.velocity.z = (direction.z * current_speed)
	

func set_tree_blend():
	var player_velocity: Vector3 = player.velocity * player.transform.basis
	var blend_position: Vector2 = Vector2(player_velocity.x, -player_velocity.z)
	
	player.model.set_tree_parameter("parameters/StateMachine/walk/blend_position", blend_position)
	player.model.set_tree_parameter("parameters/StateMachine/run/blend_position", blend_position)


	player.move_and_slide()

func _on_state_machine_state_enter(state:SD_State):
	player.model.tree.get("parameters/StateMachine/playback").travel(state.name)
	print(state)
