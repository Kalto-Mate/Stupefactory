extends CharacterBody2D
class_name ItemClass

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

@export var SpriteSheets: Array[Texture2D] #Assumed Order Triangle, Square, Round

func _ready():
	currentWalkSpeed = walkSpeed
	
	#Signals to globally control walker atributes
	Signals.walkSpeedChanged.connect(_setBaseSpeed)
	Signals.seeSawIsMoving.connect(_PauseWalking)
	self._randomizeSelf()

func _physics_process(DELTA):
	
	#==FAKE GRAVITY==
	velocity.y += gravity * DELTA
	velocity.x = currentWalkSpeed
	
	#The above does nothing by itself, we need to make the movement happen manually:
	self.move_and_slide()
	
	#==VISUALS ROTATING BASED ON SLOPE
	var normal = raycast.get_collision_normal()
	sprite.rotation = -normal.angle_to(Vector2.UP) #set rotation to the angle "left" to be aligned with UP

func _setBaseSpeed(value:float): # SUBSCRIBED TO SIGNAL walkSpeedChanged
	self.walkSpeed = value

func _PauseWalking(state:bool):
	if state==true && !self.isOnPlatform:
		currentWalkSpeed = walkSpeed * speedDecrement
	else:
		currentWalkSpeed = walkSpeed
	pass
func _randomizeSelf():
	var randShape : int = randi_range(0,SpriteSheets.size()-1)
	self.sprite.texture = SpriteSheets[randShape]
	self.Shape = randShape
	
	var randColour : int = randi_range(0,Enums.Colour.size()-1)
	self.sprite.frame_coords.x = randColour
	self.Colour = randColour
	
	var randFamily : int = randi_range(0,Enums.Family.size()-1)
	self.sprite.frame_coords.y = randFamily
	self.Family = randFamily
	
	#print ("Selfrand into [",Enums.Shape.keys()[randShape],Enums.Colour.keys()[randColour],Enums.Family.keys()[randFamily],"]")
