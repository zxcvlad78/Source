@icon("res://addons/simusdev/Game/icons/ui_icon_star.png")
extends SD_ShopNode
class_name SD_ShopNodeItem

@export var consumable: bool = false
@export var cost: int = 0
@export var for_currency: SD_ShopNodeCurrency

@export var _status: int = 0

func _on_initialized_() -> void:
	_status = get_or_write_data_as_command("status", _status).get_value_as_int()

func is_purchased() -> bool:
	return _status > 0

func get_status() -> int:
	return _status

func set_status(value: int) -> void:
	_status = value
	write_data_as_command("status", value)

func buy_item_for(currency: SD_ShopNodeCurrency) -> bool:
	if not for_currency:
		console.write_from_object(self, "buy_item_for(currency) currency == null!", SD_ConsoleCategories.CATEGORY.ERROR)
		return false
	
	if currency.get_value() >= cost and (not is_purchased()):
		
		if not consumable:
			set_status(1)
		
		currency.subtract_value(cost)
		
		get_shop().EVENT_PURCHASED.set_item(self).publish()
		
		get_shop().item_purchased.emit(self, get_shop().EVENT_PURCHASED)
		return true
		
	
	var reason_id: int = SD_ShopEventFailedToPurchase.REASON.NOT_ENOUGH_CURRENCY
	if is_purchased():
		reason_id = SD_ShopEventFailedToPurchase.REASON.ALREADY_PURCHASED
	
	get_shop().EVENT_FAILED_TO_PURCHASE.set_item(self).set_reason(reason_id).publish()
	
	get_shop().item_failed_purchase.emit(self, get_shop().EVENT_FAILED_TO_PURCHASE)
	return false

func try_buy_item() -> bool:
	return buy_item_for(for_currency)

func _on_command_data_updated(command: SD_ConsoleCommand, key: String) -> void:
	match key:
		"status":
			_status = command.get_value_as_int()
