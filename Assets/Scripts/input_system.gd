extends Node

@export var InputMachines: Array[InputMachine]

var lastSortModeChoice : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomiseSortParameters()
	Signals.reachedInsertionLimit.connect(randomiseSortParameters)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func randomiseSortParameters():
	InputMachines.shuffle()
	#We make sure we don't randomnly choose the same mode we were in by recording it and removing it from the choices
	var modeChoices = [0, 1, 2]
	modeChoices.erase(lastSortModeChoice)
	var randMode : int = modeChoices[ randi_range(0,modeChoices.size()-1) ]
	
	lastSortModeChoice = randMode
	
	match randMode:
		Enums.SortMode.Shape:
			for n in range(0,InputMachines.size()):
				InputMachines[n].SetSortByShape(n)
				#print("<<<",n,">>>")
			
		Enums.SortMode.Family:
			for n in range(0,InputMachines.size()):
				InputMachines[n].SetSortByFamily(n)
				#print("<<<",n,">>>")
				
		Enums.SortMode.Colour:
			for n in range(0,InputMachines.size()):
				InputMachines[n].SetSortByColour(n)
				#print("<<<",n,">>>")

	



