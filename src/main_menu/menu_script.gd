extends Control

@onready var bg_texture = $bg_texture

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	bg_texture.texture.noise.offset.x += 10 * delta
