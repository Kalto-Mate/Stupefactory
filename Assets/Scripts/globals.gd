extends Node

var Game_Speed : float = 1
const  _min_Game_Speed : float = 0
const  _max_Game_Speed : float = 4

func increaseGameSpeedBy(ammount : float):
	self.Game_Speed += ammount
	self.Game_Speed = clamp(self.Game_Speed,_min_Game_Speed,_max_Game_Speed)
	
	Signals.gameSpeedChanged.emit(self.Game_Speed)
	
	#DEBUG CODE
	var DebugMessage : String = "GameSpeed: " + str(self.Game_Speed)
	Signals.debugPrint.emit(DebugMessage)
