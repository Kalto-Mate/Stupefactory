extends Node2D
class_name  InputMachine

@export var DetectionArea: Area2D

var SortMode : Enums.SortMode = Enums.SortMode.Shape

var Shape : Enums.Shape = Enums.Shape.Triangular
var Family : Enums.Family = Enums.Family.Cars
var Colour : Enums.Colour = Enums.Colour.Gray

func _ready():
	DetectionArea.body_entered.connect(_processItem)

func SetFilter(_SortMode: Enums.SortMode,_Shape: Enums.Shape,_Family: Enums.Family,_Colour: Enums.Colour):
	self.SortMode = _SortMode
	self.Shape = _Shape
	self.Family = _Family
	self.Colour = _Colour

func _processItem(body:Node2D):
	var Item : ItemClass = body
	#Check how item compares to the mode the machine is on
	if self._ItemIsCorrectType(Item):
		print(Item.name, " is the correct type, score points")
	else:
		print(Item.name, " is NOT the correct type, deduct points")

	Item.queue_free()
	
func _ItemIsCorrectType (Item:ItemClass) -> bool :
	var result : bool = false
	if !Item.is_class("ItemClass"):
		return result
	
	print ("[",self.SortMode,self.Shape,self,Family,self.Colour,"]->(",Item.Shape,Item,Family,Item.Colour,")")
	match self.SortMode:
		Enums.SortMode.Shape:
			result = self.Shape == Item.Shape
		Enums.SortMode.Family:
			result = self.Family == Item.Family
		Enums.SortMode.Colour:
			result = self.Colour == Item.Colour
			
	return result
