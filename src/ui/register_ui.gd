extends Control

@onready var username_line = $username
@onready var password_line = $password

var cfg:SD_Config = SD_Config.new()

func register():
	if username_line.text == "" or password_line.text == "":
		return
	
	cfg.set_value("user", "name", username_line.text)
	cfg.set_value("user", "password", password_line.text)
	
	cfg.save("user://player_data.cfg")

func login():
	pass



func _on_enter_button_button_up() -> void:
	pass # Replace with function body.
