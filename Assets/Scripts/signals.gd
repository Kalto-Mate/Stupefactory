extends Node

#pi = Player Input
signal pi_tiltPositive
signal pi_tiltNegative

#General Events
signal seeSawIsMoving(status:bool)
signal gameSpeedChanged(value:float)
signal objectInserted
signal objectDeleted
signal reachedInsertionLimit
signal aboutToReachInsertionLimit

#Scoring
signal wrongSort
signal correctSort

#Debug
signal debugPrint(message:String)
