class_name FP_PlayerPhysics extends PlayerBaseComponent

@export var gravity:float = 9.8

func _process_gravity(delta: float):
	if not player.is_on_floor():
		player.velocity.y -= pow(gravity, 2 * delta) 

func _physics_process(delta: float) -> void:
	_process_gravity(delta)
