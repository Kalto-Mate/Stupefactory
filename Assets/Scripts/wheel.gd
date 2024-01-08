extends Sprite2D
@export var animator : AnimationPlayer

func _ready():
	animator.play("Rotate_clockwise")
	Signals.gameSpeedChanged.connect(_changeAnimSpeed)

func _changeAnimSpeed(newSpeed: float):
	animator.speed_scale = clamp(newSpeed,-10,Globals.maxAnimSpeed)
