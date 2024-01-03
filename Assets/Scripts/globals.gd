extends Node
#GAME STATUS================================================================================
var Game_Speed : float
const RESET_Game_Speed : float = 1
const gameSpeedIncrease_interval = 0.1

var Score : int
const RESET_Score : int = 0

var InsertionCounter : int  #Keeps tracks of the number of items that made it to a machine
const RESET_InsertionCounter : int = 0

#CONFIG====================================================================================
const _min_Game_Speed : float = 0
const _max_Game_Speed : float = 4
const _triggerModeChangeAt : int = 5 #The number of items that need to make it to a machine

func _ready():
	resetAll()
	increaseGameSpeedBy(0.5)
	
	Signals.objectInserted.connect(increaseInsertionCounter)
	Signals.reachedInsertionLimit.connect(increaseGameSpeed)

func increaseGameSpeedBy(ammount : float):
	self.Game_Speed += ammount
	self.Game_Speed = clamp(self.Game_Speed,_min_Game_Speed,_max_Game_Speed)
	
	Signals.gameSpeedChanged.emit(self.Game_Speed)
	
	#DEBUG CODE
	var DebugMessage : String = "GameSpeed: " + str(self.Game_Speed)
	Signals.debugPrint.emit(DebugMessage)

func increaseGameSpeed():
	increaseGameSpeedBy(gameSpeedIncrease_interval)


func increaseInsertionCounter():
	self.InsertionCounter += 1
	
	if self.InsertionCounter == _triggerModeChangeAt -1 :
		Signals.aboutToReachInsertionLimit.emit()
	if self.InsertionCounter >= _triggerModeChangeAt :
		Signals.reachedInsertionLimit.emit()
		self.InsertionCounter = 0
	#DEBUG CODE
	var DebugMessage : String = "In: " + str(self.InsertionCounter)
	Signals.debugPrint.emit(DebugMessage)
	
func resetAll():
	self.Game_Speed = RESET_Game_Speed
	self.Score = RESET_Score
	self.InsertionCounter = RESET_InsertionCounter
