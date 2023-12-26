extends CharacterBody2D
class_name WalkerClass

@export var Shape : Enums.Shape
@export var Family: Enums.Family
@export var Colour: Enums.Colour

const gravity : float = 1000
var walkSpeed : float = 30
var currentWalkSpeed : float

var isOnPlatform : bool = true
var speedDecrement : float = 0

@export var raycast : RayCast2D
@export var sprite : Sprite2D

func _ready():
	currentWalkSpeed = walkSpeed
	#Signals to globally control walker atributes
	Signals.walkSpeedChanged.connect(_setWalkSpeed)
	Signals.seeSawIsMoving.connect(_PauseWalking)

func _physics_process(DELTA):
	
	#==FAKE GRAVITY==
	velocity.y += gravity * DELTA
	velocity.x = currentWalkSpeed
	
	#The above does nothing by itself, we need to make the movement happen manually:
	self.move_and_slide()
	
	#==VISUALS ROTATING BASED ON SLOPE

	
	
	var normal = raycast.get_collision_normal()
	sprite.rotation = -normal.angle_to(Vector2.UP) #set rotation to the angle "left" to be aligned with UP

func _setWalkSpeed(value:float): # SUBSCRIBED TO SIGNAL walkSpeedChanged
	self.walkSpeed = value


func _PauseWalking(state:bool):
	if state==true && !self.isOnPlatform:
		currentWalkSpeed = walkSpeed * speedDecrement
	else:
		currentWalkSpeed = walkSpeed
	pass
