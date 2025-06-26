extends Control

@onready var _base: SD_TrunkConsole = SimusDev.console
@export var _tips: Control

@export var _drag: SE_UIControlDrag

@export var toolbar_container: VBoxContainer

signal toolbutton_pressed(button: Button)

func _ready() -> void:
	_tips.initialize(_base)
	
	var upd_commands: Array[SD_ConsoleCommand] = [
		_base.create_command("ui.console.zoom", 1.0),
		_base.create_command("ui.console.position", Vector2(0, 0)),
	]
	
	for cmd in upd_commands:
		cmd.updated.connect(_on_command_updated.bind(cmd))
		cmd.update_command()
	
	
	for child in toolbar_container.get_children():
		if child is Button:
			child.pressed.connect(_on_toolbar_button_pressed.bind(child))

func _on_toolbar_button_pressed(button: Button) -> void:
	toolbutton_pressed.emit(button)

func _on_command_updated(cmd: SD_ConsoleCommand) -> void:
	match cmd.get_code():
		"ui.console.zoom":
			_drag.set_zoom(cmd.get_value_as_float())
		"ui.console.position":
			position = cmd.get_value_as_vector2()

func _on_se_ui_control_drag_drag_start() -> void:
	pass # Replace with function body.

func _on_se_ui_control_drag_drag_end() -> void:
	_base.create_command("ui.console.position", Vector2(0, 0)).set_value(position)
	_base.create_command("ui.console.zoom", 1.0).set_value(_drag.current_zoom)

func _on_line_edit_text_submitted(new_text: String) -> void:
	_base.try_execute($LineEdit.text)
	$LineEdit.text = ""
	_tips.clear_tips()
	


func _on_draw() -> void:
	$LineEdit.grab_focus()

func _on_line_edit_text_changed(new_text: String) -> void:
	_tips.update_tips(new_text)

func _on_sd_node_console_commands_on_executed(command: SD_ConsoleCommand) -> void:
	if command.get_code() == "clear" or command.get_code() == "console.clear":
		_base.clear_message_buffer()
		$ui_console_output.clear_messages()

func _on_ui_console_tips_tip_selected(cmd: SD_ConsoleCommand) -> void:
	$LineEdit.text = ""
	$LineEdit.insert_text_at_caret(cmd.get_code() + " " + cmd.get_value_as_string())
	$LineEdit.grab_focus()
