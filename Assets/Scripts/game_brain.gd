extends Node
@export var SequencePlayer : AnimationPlayer
@export var levelUp_animname : String = "levelUp_sequence"
@export var gameOver_animname : String = "gameOver_sequence"
func _ready():
	Signals.reachedInsertionLimit.connect(playLevelUpSequence)
	Signals.healthReachedZero.connect(playGameOverSequence)
	Signals.pi_restartGame.connect(RestartGame)
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
	Globals.setGameOver(true)
	SequencePlayer.play(gameOver_animname)
	
func HaltGameSpeed(): #Called from Animator
	Globals.gameOverSpeed()
func OpenMenu():#Called from Animator
	Signals.openMenu.emit(true)

func RestartGame():
	#print("GameBrain: Restarting Game")
	Globals.restartCounter += 1
	Globals.resetAll()
	get_tree().reload_current_scene()
