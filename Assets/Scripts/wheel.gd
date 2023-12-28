extends Sprite2D
@export var animator : AnimationPlayer

func _ready():
	animator.play("Rotate_clockwise")

