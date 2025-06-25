extends SD_AdsSDK
class_name SD_AdsSDKDesktop

var _interface: desktop_ads_interface

func _on_initialized() -> void:
	var interface_scene: PackedScene = load("res://addons/simusdev/monetization/desktop/desktop_ads_interface.tscn")
	_interface = interface_scene.instantiate()
	SimusDev.canvas.get_last_layer().add_child(_interface)

func get_interface() -> desktop_ads_interface:
	return _interface

func _show_interstitial_placeholder_() -> void:
	_interface.open_ad(_interface.interstitial_scene)

func _show_reward_placeholder_() -> void:
	_interface.open_ad(_interface.reward_scene)
