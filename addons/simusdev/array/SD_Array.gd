extends SD_Object
class_name SD_Array


static func append_to_array(array: Array, value, repeat := true) -> void:
	if !repeat and array.has(value):
		return
	array.append(value)

static func append_to_array_no_repeat(array: Array, value) -> void:
	append_to_array(array, value, false)

static func erase_from_array(array: Array, value) -> void:
	if array.has(value):
		array.erase(value)

static func get_value_from_array(array: Array, index: int, default = null):
	if index > array.size() - 1:
		return default
	return array[index] 

static func get_random_value_from_array(array: Array, default = null):
	if array.is_empty():
		return default
	
	var picked_index: int = SD_Random.get_rint_range(0, array.size() - 1)
	return get_value_from_array(array, picked_index, default)
	
