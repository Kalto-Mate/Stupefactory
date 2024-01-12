extends Node
#GAME STATUS================================================================================
var seeSawPosition : int
const RESET_seeSawPosition = 0
var GameIsOver : bool = false

var Game_Speed : float
var Game_Speed_STORE : float
const RESET_Game_Speed : float = 1.5
const gameSpeedIncrease_interval = 0.3

var Score : int
const RESET_Score : int = 0
const maxScore : int = 999999
var Health : float
const RESET_Health : float = 100

var InsertionCounter : int  #Keeps tracks of the number of items that made it to a machine
const RESET_InsertionCounter : int = 0
var _triggerModeChangeAt : int #The number of items that need to make it to a machine
const RESET_triggerModeChangeAt : int = 3
var _triggerModeChangeAt_FLOAT : float

#region CONFIG====================================================================================
const _min_Game_Speed : float = -1
const _max_Game_Speed : float = 10
const maxAnimSpeed : float = 8.1
const minSpawnSpeed : float = 0.8
const _triggerModeChangeAt_IncreaseInterval : float = 0.2

const wrongSortPenalty : float = 18
const correctSortReward : float = 6
const correctSortPoints : int = 150
const itemFellPenalty : float = 5
#endregion

#REFERENCES================================================================================
var InputMachines: Array[InputMachine]

func _ready():
	resetAll()
	
	Signals.objectInserted.connect(increaseInsertionCounter)
	Signals.seeSawChangedPosition.connect(updateSeeSawPos)
	
	Signals.wrongSort.connect(wrongSortDamage)
	Signals.ItemFell.connect(itemFellDamage)
	Signals.correctSort.connect(correctSortScore)

func setGameSpeedTo(ammount : float):
	self.Game_Speed = ammount
	self.Game_Speed = clamp(self.Game_Speed,_min_Game_Speed,_max_Game_Speed)
	
	Signals.gameSpeedChanged.emit(self.Game_Speed)
	
	#DEBUG CODE
	#var DebugMessage : String = "GameSpeed: " + str(self.Game_Speed)
	#Signals.debugPrint.emit(DebugMessage)

func increaseGameSpeedBy(ammount : float):
	setGameSpeedTo(self.Game_Speed + ammount)

func increaseGameSpeed():
	setGameSpeedTo(self.Game_Speed + self.gameSpeedIncrease_interval)
	_triggerModeChangeAt_FLOAT += _triggerModeChangeAt_IncreaseInterval
	self._triggerModeChangeAt = round(_triggerModeChangeAt_FLOAT)
	#print("ChangeModeAt = " , self._triggerModeChangeAt, " (",self._triggerModeChangeAt_FLOAT , ")")
	
func pauseGameSpeed():
	self.Game_Speed_STORE = self.Game_Speed
	setGameSpeedTo(-1)
	
func unpauseGameSpeed():
	setGameSpeedTo(self.Game_Speed_STORE)

func gameOverSpeed():
	setGameSpeedTo(0)
	
func increaseInsertionCounter():
	self.InsertionCounter += 1
	
	if self.InsertionCounter == _triggerModeChangeAt -1 :
		Signals.aboutToReachInsertionLimit.emit()
	if self.InsertionCounter >= _triggerModeChangeAt :
		Signals.reachedInsertionLimit.emit()
		self.InsertionCounter = 0
	#DEBUG CODE
	#var DebugMessage : String = "In: " + str(self.InsertionCounter)
	#Signals.debugPrint.emit(DebugMessage)

func updateSeeSawPos(pos:int):
	#var debugMessage = "SeeSawPos: " + str(pos)
	#Signals.debugPrint.emit(debugMessage)
	self.seeSawPosition = pos

#region HEALTH FUNCTIONALITY =========================================================
func modifyHealth (ammount : float):
	var newHealth : float = self.Health + ammount
	self.Health = clamp(newHealth,0,RESET_Health)
	Signals.healthChanged.emit(self.Health)
	if self.Health <= 0	:
		Signals.healthReachedZero.emit()
	
func setHealth (ammount : float):
	self.Health = clamp(ammount,0,RESET_Health)
	Signals.healthChanged.emit(self.Health)

func wrongSortDamage():
	self.modifyHealth(-1 * wrongSortPenalty)
	
func itemFellDamage():
	self.modifyHealth(-1 * itemFellPenalty)
	
func correctSortScore():
	self.modifyHealth(abs (correctSortReward) )
	self.scorePoints (correctSortPoints)
#endregion

#region SCORE FUNCTIONALITY =========================================================
func scorePoints (ammount : int):
	var newScore : float = self.Score + ammount
	self.Score = clamp(newScore,0,maxScore)
	Signals.scoreChanged.emit(self.Score)
	
func setScore (ammount : int):
	self.Score = clamp(ammount,0,maxScore)
	Signals.scoreChanged.emit(self.Score)
#endregion ==============================================================================

#region GAME LOGIC ========================================================
func resetAll():
	self.GameIsOver = false
	updateSeeSawPos(RESET_seeSawPosition)
	self.Game_Speed = RESET_Game_Speed
	setScore(RESET_Score)
	setHealth(RESET_Health)
	self.InsertionCounter = RESET_InsertionCounter
	self._triggerModeChangeAt = RESET_triggerModeChangeAt
	self._triggerModeChangeAt_FLOAT = RESET_triggerModeChangeAt

func setGameOver(state:bool):
	self.GameIsOver = state
#endregion
