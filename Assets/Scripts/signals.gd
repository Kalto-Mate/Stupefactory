extends Node

#pi = Player Input
signal pi_tiltPositive
signal pi_tiltNegative

#General Events
signal seeSawIsMoving(status:bool)
signal seeSawChangedPosition(newPos:int)
signal gameSpeedChanged(value:float)
signal objectInserted
signal reachedInsertionLimit
signal aboutToReachInsertionLimit

#Scoring
signal wrongSort
signal correctSort
signal ItemFell
signal healthChanged(value:float)
signal scoreChanged(value:int)

#Debug
signal debugPrint(message:String)
