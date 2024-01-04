extends Node
#GAME STATUS================================================================================
var Game_Speed : float
var Game_Speed_STORE : float
const RESET_Game_Speed : float = 1.5
const gameSpeedIncrease_interval = .33333

var Score : int
const RESET_Score : int = 0

var InsertionCounter : int  #Keeps tracks of the number of items that made it to a machine
const RESET_InsertionCounter : int = 0

var _triggerModeChangeAt : int #The number of items that need to make it to a machine
const RESET_triggerModeChangeAt : int = 3
var _triggerModeChangeAt_FLOAT : float
#CONFIG====================================================================================
const _min_Game_Speed : float = -1
const _max_Game_Speed : float = 8.1
const _triggerModeChangeAt_IncreaseInterval : float = 0.4

func _ready():
	resetAll()
	Signals.objectInserted.connect(increaseInsertionCounter)

func setGameSpeedTo(ammount : float):
	self.Game_Speed = ammount
	self.Game_Speed = clamp(self.Game_Speed,_min_Game_Speed,_max_Game_Speed)
	
	Signals.gameSpeedChanged.emit(self.Game_Speed)
	
	#DEBUG CODE
	var DebugMessage : String = "GameSpeed: " + str(self.Game_Speed)
	Signals.debugPrint.emit(DebugMessage)

func increaseGameSpeedBy(ammount : float):
	setGameSpeedTo(self.Game_Speed + ammount)

func increaseGameSpeed():
	setGameSpeedTo(self.Game_Speed + self.gameSpeedIncrease_interval)
	_triggerModeChangeAt_FLOAT += _triggerModeChangeAt_IncreaseInterval
	self._triggerModeChangeAt = round(_triggerModeChangeAt_FLOAT)
	print("ChangeModeAt = " , self._triggerModeChangeAt, " (",self._triggerModeChangeAt_FLOAT , ")")
	
func pauseGameSpeed():
	self.Game_Speed_STORE = self.Game_Speed
	setGameSpeedTo(-1)
	
func unpauseGameSpeed():
	setGameSpeedTo(self.Game_Speed_STORE)


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
	self._triggerModeChangeAt = RESET_triggerModeChangeAt
	self._triggerModeChangeAt_FLOAT = RESET_triggerModeChangeAt
