extends Node2D
class_name  InputMachine

@export var DetectionArea: Area2D
@export var Screen : Sprite2D

var SortMode : Enums.SortMode

var Shape : Enums.Shape
var Family : Enums.Family
var Colour : Enums.Colour

func _ready():
	DetectionArea.body_entered.connect(_processItem)
	self.SetSortByShape(Enums.Shape.Triangular)

func SetSortByShape(_Shape: Enums.Shape):
	self.SortMode = Enums.SortMode.Shape
	self.Shape = _Shape
	Screen.frame_coords = Vector2(_Shape,Enums.SortMode.Shape)

func SetSortByFamily(_Family: Enums.Family):
	self.SortMode = Enums.SortMode.Family
	self.Family = _Family
	Screen.frame_coords = Vector2(_Family,Enums.SortMode.Family)

func SetSortByColour(_Colour: Enums.Colour):
	self.SortMode = Enums.SortMode.Colour
	self.Colour = _Colour
	Screen.frame_coords = Vector2(_Colour,Enums.SortMode.Colour)

func _processItem(body:Node2D):
	var Item = body as ItemClass
	#Check how item compares to the mode the machine is on
	if self._ItemIsCorrectType(Item):
		print(Item.name, " is the correct type, score points")
	else:
		print(Item.name, " is NOT the correct type, deduct points")
	
	Item.queue_free()
	Signals.objectInserted.emit()

func _ItemIsCorrectType (Item:ItemClass) -> bool :
	var result : bool = false
	match self.SortMode:
		Enums.SortMode.Shape:
			print("Expected: ", Enums.Shape.keys()[self.Shape]," Received: ",Enums.Shape.keys()[Item.Shape])
			result = self.Shape == Item.Shape
		Enums.SortMode.Family:
			print("Expected: ", Enums.Family.keys()[self.Family]," Received: ",Enums.Family.keys()[Item.Family])
			result = self.Family == Item.Family
		Enums.SortMode.Colour:
			print("Expected: ", Enums.Colour.keys()[self.Colour]," Received: ",Enums.Colour.keys()[Item.Colour])
			result = self.Colour == Item.Colour
			
	return result
