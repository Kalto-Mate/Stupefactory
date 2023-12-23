extends Node2D
@export var DetectionArea: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	DetectionArea.body_entered.connect(_processWalker)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _processWalker(body:Node2D):
	print("Processed ",body.name)
	body.queue_free()
	pass
