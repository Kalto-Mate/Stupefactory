extends CharacterBody2D
const gravity : float = 2000
var walkSpeed : float = 30

func _ready():
	#Signals to globally control walker atributes
	Signals.walkSpeedChanged.connect(_setWalkSpeed)

func _physics_process(DELTA):
	
	#==FAKE GRAVITY==
	velocity.y += gravity * DELTA
	velocity.x = walkSpeed
	
	#The above does nothing by itself, we need to make the movement happen manually:
	self.move_and_slide()

func _setWalkSpeed(value:float): # SUBSCRIBED TO SIGNAL walkSpeedChanged
	self.walkSpeed = value
