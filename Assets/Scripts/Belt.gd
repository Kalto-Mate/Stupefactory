extends Sprite2D
@export var animator : AnimationPlayer
@export var animationName : String

func _ready():
	animator.play(animationName)
	Signals.gameSpeedChanged.connect(_changeAnimSpeed)

func _changeAnimSpeed(newSpeed: float):
	animator.speed_scale = clamp(newSpeed,-10,Globals.maxAnimSpeed)
