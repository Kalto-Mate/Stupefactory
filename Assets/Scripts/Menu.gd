extends Node
@export var animator: AnimationPlayer
const animName:String = "OpenMenu"
const openTime : float = .5
const closeTime : float = .5
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.openMenu.connect(openMenu)

func openMenu(state:bool):
	animator.stop()
	if state:
		animator.speed_scale = 1/openTime
		#menu opening stuff
	else:
		animator.speed_scale = 1/-closeTime
	
	animator.play(animName)
