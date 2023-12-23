extends Sprite2D
@export var ExemptArea: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ExemptArea.body_entered.connect(_WalkerEnteredPlatform)
	ExemptArea.body_exited.connect(_WalkerExitedPlatform)

func _physics_process(delta):
	pass

func _WalkerEnteredPlatform(walker:WalkerClass):
	walker.isOnPlatform = true
func _WalkerExitedPlatform(walker:WalkerClass):
	walker.isOnPlatform = false
	
