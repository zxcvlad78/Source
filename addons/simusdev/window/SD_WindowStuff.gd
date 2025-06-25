extends SD_Object
class_name SD_WindowStuff

static func get_project_viewport_size() -> Vector2:
	var x: int = ProjectSettings.get("display/window/size/viewport_width")
	var y: int = ProjectSettings.get("display/window/size/viewport_height")
	return Vector2(x, y)
