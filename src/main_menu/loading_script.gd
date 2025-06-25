extends Control

@onready var menu = $"../menu"
@onready var loading = $"."
@onready var label = $label
@onready var loader = $loader

func _ready() -> void:
	#прикольный scripting coding faking ez 
	$label.text = "Loading"
	var counter:int = 0
	while true:
		await  get_tree().create_timer(.5).timeout
		if counter < 3:
			counter += 1
			$label.text += "."
		else:
			counter = 0
			$label.text = "Loading"

func _on_loader_loading_started() -> void:
	menu.hide()
	self.show()

func _on_loader_loading_finished() -> void:
	menu.show()
	self.hide()
