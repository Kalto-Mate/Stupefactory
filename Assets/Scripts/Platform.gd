extends Node2D
@export var ExemptArea: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ExemptArea.body_entered.connect(_ItemEnteredPlatform)
	ExemptArea.body_exited.connect(_ItemExitedPlatform)

func _ItemEnteredPlatform(Item:Node2D):
	if Item.is_class("ItemClass"):
		Item.isOnPlatform = true
func _ItemExitedPlatform(Item:Node2D):
	if Item.is_class("ItemClass"):
		Item.isOnPlatform = false
	
