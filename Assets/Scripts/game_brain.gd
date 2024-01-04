extends Node
@export var SequencePlayer : AnimationPlayer
@export var levelUp_animname : String = "levelUp_sequence"

func _ready():
	Signals.reachedInsertionLimit.connect(playLevelUpSequence)


func playLevelUpSequence():
	#MAKE THIS INTO AN ANIMATOR SEQUENCE WITH A STOP AND A FASTER RESUME
	SequencePlayer.play(levelUp_animname)
	pass

func increaseSpeedAndPause():
	Globals.increaseGameSpeed()
	Globals.pauseGameSpeed()

func unPauseGameSpeed():
	Globals.unpauseGameSpeed()
