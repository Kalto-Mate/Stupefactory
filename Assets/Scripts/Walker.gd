extends CharacterBody2D
class_name WalkerClass

const gravity : float = 3000
var walkSpeed : float = 30
var currentWalkSpeed : float

var isOnPlatform : bool = true

func _ready():
	currentWalkSpeed = walkSpeed
	#Signals to globally control walker atributes
	Signals.walkSpeedChanged.connect(_setWalkSpeed)
	Signals.seeSawIsMoving.connect(_PauseWalking)

func _physics_process(DELTA):
	#==DETERMINE IF EXEMPT FROM STOPPING
	
	#==FAKE GRAVITY==
	velocity.y += gravity * DELTA
	velocity.x = currentWalkSpeed
	
	#The above does nothing by itself, we need to make the movement happen manually:
	self.move_and_slide()

func _setWalkSpeed(value:float): # SUBSCRIBED TO SIGNAL walkSpeedChanged
	self.walkSpeed = value
func _PauseWalking(state:bool):
	if state==true && !self.isOnPlatform:
		currentWalkSpeed = 0
	else:
		currentWalkSpeed = walkSpeed
	pass
