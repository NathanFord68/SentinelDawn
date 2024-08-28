class_name InventorySlot
extends PanelContainer

var item : Item = preload("res://models/iron_plate/iron_plate.tscn").instantiate()
var quantity: int		

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(make_drag_preview())
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	print_debug(data)
	if data is not Item:
		return false
	print_debug("Can drop")
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	print_debug(quantity)
	print_debug(data.quantity)
	
func make_drag_preview() -> TextureRect:
	var t := TextureRect.new()
	t.texture = load(item.icon)
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size
	return t

func update_icon():
	if not is_instance_valid(item):
		return
	
	$TextureRect.texture = load(item.icon)
	$Label.text = "" if quantity == 0 or quantity == 1 else str(quantity)
