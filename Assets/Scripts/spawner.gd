extends Node2D
class_name SpawnerClass

@export var ItemPrefab: PackedScene
@export var Animator: AnimationPlayer


func spawnItem():
	Animator.play("siren_flash")
	var newItem = ItemPrefab.instantiate()
	newItem.global_position = self.global_position
	add_sibling(newItem)
