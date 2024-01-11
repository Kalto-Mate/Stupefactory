extends Node
@export var SequencePlayer : AnimationPlayer
@export var levelUp_animname : String = "levelUp_sequence"
@export var gameOver_animname : String = "gameOver_sequence"
func _ready():
	Signals.reachedInsertionLimit.connect(playLevelUpSequence)
	Signals.healthReachedZero.connect(playGameOverSequence)

#region LEVEL UP SEQUENCE

func playLevelUpSequence():
	#MAKE THIS INTO AN ANIMATOR SEQUENCE WITH A STOP AND A FASTER RESUME
	SequencePlayer.play(levelUp_animname)


func increaseSpeedAndPause():
	Globals.increaseGameSpeed()
	Globals.pauseGameSpeed()

func unPauseGameSpeed():
	Globals.unpauseGameSpeed()
#endregion

#region GAME OVER SEQUENCE
func playGameOverSequence():
	SequencePlayer.play(gameOver_animname)
func HaltGameSpeed():
	Globals.gameOverSpeed()
