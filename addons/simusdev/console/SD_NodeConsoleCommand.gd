extends SD_NodeConsole
class_name SD_NodeConsoleCommand

@export var command: SD_NodeCommandObject

signal on_executed(command: SD_ConsoleCommand)
signal on_updated(command: SD_ConsoleCommand)

func _ready() -> void:
	if command:
		var cmd := console.create_command(command.code, command.value)
		cmd.executed.connect(__on_executed.bind(cmd))
		cmd.updated.connect(__on_updated.bind(cmd))

func __on_executed(cmd: SD_ConsoleCommand) -> void:
	on_executed.emit(cmd)

func __on_updated(cmd: SD_ConsoleCommand) -> void:
	on_updated.emit(cmd)

func get_command() -> SD_ConsoleCommand:
	return console.create_command(command.code, command.value) as SD_ConsoleCommand
