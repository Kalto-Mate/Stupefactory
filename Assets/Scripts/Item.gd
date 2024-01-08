extends CharacterBody2D
class_name ItemClass

@export var Shape : Enums.Shape
@export var Family: Enums.Family
@export var Colour: Enums.Colour

const gravity : float = 1000
const baseWalkSpeed : float = 21

var currentBaseSpeed : float
var currentGameSpeed : float
var solvedWalkSpeed : float = 1

var isOnPlatform : bool = true
var speedDecrement : float = 1

@export var raycast : RayCast2D
@export var sprite : Sprite2D

@export var SpriteSheets: Array[Texture2D] #Assumed Order Triangle, Square, Round
@export var debugLabel : Label
var reRandomizationCounter : int = 0

func _ready():
	Signals.seeSawIsMoving.connect(_PauseWalking)
	Signals.gameSpeedChanged.connect(_updateCurrentBaseSpeed)
	currentGameSpeed = Globals.Game_Speed
	currentBaseSpeed = baseWalkSpeed * currentGameSpeed
	self._randomizeSelf()

func _physics_process(DELTA):
	
	#==FAKE GRAVITY==
	velocity.y += gravity * DELTA
	velocity.x = currentBaseSpeed
	
	#The above does nothing by itself, we need to make the movement happen manually:
	self.move_and_slide()
	
	#==VISUALS ROTATING BASED ON SLOPE
	var normal = raycast.get_collision_normal()
	sprite.rotation = -normal.angle_to(Vector2.UP) #set rotation to the angle "left" to be aligned with UP

func _PauseWalking(state:bool):
	if state==true && !self.isOnPlatform:
		currentBaseSpeed = baseWalkSpeed * currentGameSpeed
		#currentBaseSpeed = baseWalkSpeed * speedDecrement
	else:
		currentBaseSpeed = baseWalkSpeed * currentGameSpeed
	pass

func _updateCurrentBaseSpeed(newGameSpeed:float):
	currentGameSpeed = newGameSpeed
	currentBaseSpeed = baseWalkSpeed * currentGameSpeed

func _randomizeSelf():
	var randShape : int = randi_range(0,SpriteSheets.size()-1)
	self.sprite.texture = SpriteSheets[randShape]
	self.Shape = randShape as Enums.Shape
	
	var randColour : int = randi_range(0,Enums.Colour.size()-1)
	self.sprite.frame_coords.x = randColour
	self.Colour = randColour as Enums.Colour
	
	var randFamily : int = randi_range(0,Enums.Family.size()-1)
	self.sprite.frame_coords.y = randFamily
	self.Family = randFamily as Enums.Family
	
	#debugLabel.text = Enums.Shape_name [self.Shape]  \
					#+ Enums.Family_name[self.Family] \
					#+ Enums.Colour_name[self.Colour]
	
	var InputMachineToAsk = Globals.InputMachines[Globals.seeSawPosition+1]
	print("Asking " + InputMachineToAsk.name +" -> " + str(Globals.seeSawPosition))
	if InputMachineToAsk.ItemIsCorrectType(self) :
		#If the present randomisation is correct for the currently connected input belt, we reroll
		#This way, it becomes imposible to score points while afk since, for example, if SeeSaw is
		#connected to a belt that expects triangular objects, those will never spawn
		self._randomizeSelf()
		reRandomizationCounter += 1
		debugLabel.text = str(reRandomizationCounter)
	
