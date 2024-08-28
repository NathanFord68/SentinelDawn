class_name InventoryManager
extends Node

var total_items: Dictionary = {}
@onready var inventory = $SubViewport/MarginContainer/HBoxContainer/InventoryMarginContainer/Inventory

func add_to_inventory(item: Item) -> bool:
	var index: int = -1
	# Go through the inventory to figure out where to insert this item
	for i in len(inventory.get_children()):
		var slot: InventorySlot = inventory.get_child(i)
		if index == -1 and not is_instance_valid(slot.item):
			index = i
			
		if slot.item.item_name == item.item_name and slot.quantity < item.stack_size:
			++slot.quantity
			slot.update_icon()
			add_to_total_count(item)
			return true
			

	if index == -1:
		return false # Let the caller know that there was no slots for it
	
	(inventory.get_child(index) as InventorySlot).item = item
	(inventory.get_child(index) as InventorySlot).quantity = 1
	(inventory.get_child(index) as InventorySlot).update_icon()
	add_to_total_count(item)
	return true

func add_to_total_count(item: Item) -> void:
	if item.item_name in total_items:
		++total_items[item.item_name]
		return
	total_items[item.item_name] = 1
