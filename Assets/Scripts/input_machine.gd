extends Node2D
class_name  InputMachine

@export var DeletionArea: Area2D
@export var Screen : Sprite2D
@export var WarningAnimator : AnimationPlayer
@export var WrongAnimator : AnimationPlayer

var SortMode : Enums.SortMode

var Shape : Enums.Shape
var Family : Enums.Family
var Colour : Enums.Colour

func _ready():
	DeletionArea.body_entered.connect(_processItem)
	
	Signals.aboutToReachInsertionLimit.connect(flashWarning)
	Signals.reachedInsertionLimit.connect(stopFlashingWarning)
	
	self.SetSortByShape(Enums.Shape.Triangular)

func SetSortByShape(_Shape: Enums.Shape):
	self.SortMode = Enums.SortMode.Shape
	self.Shape = _Shape
	Screen.frame_coords = Vector2(_Shape,Enums.SortMode.Shape)
	WrongAnimator.stop()

func SetSortByFamily(_Family: Enums.Family):
	self.SortMode = Enums.SortMode.Family
	self.Family = _Family
	Screen.frame_coords = Vector2(_Family,Enums.SortMode.Family)
	WrongAnimator.stop()
	
func SetSortByColour(_Colour: Enums.Colour):
	self.SortMode = Enums.SortMode.Colour
	self.Colour = _Colour
	Screen.frame_coords = Vector2(_Colour,Enums.SortMode.Colour)
	WrongAnimator.stop()
	
func _processItem(body:Node2D):
	var Item = body as ItemClass
	#Check how item compares to the mode the machine is on
	if self.ItemIsCorrectType(Item):
		Signals.objectInserted.emit()
		#print(Item.name, " is the correct type, score points")
	else:
		self.flashWrongItem()
		#print(Item.name, " is NOT the correct type, deduct points")
	
	body.queue_free()


func ItemIsCorrectType (Item:ItemClass) -> bool :
	var result : bool = false
	match self.SortMode:
		Enums.SortMode.Shape:
			#print("Expected: ", Enums.Shape.keys()[self.Shape]," Received: ",Enums.Shape.keys()[Item.Shape])
			result = self.Shape == Item.Shape
		Enums.SortMode.Family:
			#print("Expected: ", Enums.Family.keys()[self.Family]," Received: ",Enums.Family.keys()[Item.Family])
			result = self.Family == Item.Family
		Enums.SortMode.Colour:
			#print("Expected: ", Enums.Colour.keys()[self.Colour]," Received: ",Enums.Colour.keys()[Item.Colour])
			result = self.Colour == Item.Colour
			
	return result

#Visual Functions
func flashWarning():
	WarningAnimator.play("flash_warning")
func stopFlashingWarning():
	WarningAnimator.stop()
func flashWrongItem():
	WrongAnimator.stop()
	WrongAnimator.play("flash_wrong")
