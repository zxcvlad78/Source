@tool
class_name SourceButton extends Button

@onready var rollover_stream:AudioStream = preload("res://src/sounds/ui/buttonrollover.wav")
@onready var click_stream:AudioStream = preload("res://src/sounds/ui/buttonclick.wav")
@onready var clickrelease_stream:AudioStream = preload("res://src/sounds/ui/buttonclickrelease.wav")

@onready var font = preload("res://addons/simusdev/fonts/Allods.ttf")

@export var always_flat: bool = true
@export var font_size:float = 16.0 : set = set_font_size
@export var outline_size:float = 3.0 : set = set_outline_size

func set_font_size(value:float):
	font_size = value
	set("theme_override_font_sizes/font_size", value)

func set_outline_size(value:float):
	outline_size = value
	set("theme_override_constants/outline_size", value)

func _ready() -> void:
	if always_flat:
		flat = true
	
	focus_mode = Control.FOCUS_NONE
	alignment = HORIZONTAL_ALIGNMENT_LEFT
	set("theme_override_fonts/font", font)
	
	mouse_entered.connect(_mouse_entered)
	mouse_exited.connect(_mouse_exited)
	button_down.connect(_click)
	button_up.connect(_clickrelease)

func play_audio(_stream:AudioStream):
	var audio_player:AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = _stream
	audio_player.play()
	audio_player.finished.connect(audio_player.queue_free)

func _mouse_entered():
	play_audio(rollover_stream)
func _mouse_exited():
	pass

func _click():
	play_audio(click_stream)
func _clickrelease():
	play_audio(clickrelease_stream)
