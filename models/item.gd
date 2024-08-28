class_name Item
extends RigidBody3D

@export var item_name: String
@export var icon: String
@export var stack_size: int


func on_interact(caller: Controller) -> void:
	if caller.inventory.add_to_inventory((load(scene_file_path) as PackedScene).instantiate()):
		self.queue_free()
