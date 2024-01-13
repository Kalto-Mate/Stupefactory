extends Node
class_name PlayerInput

@export var PollTimer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	#PollTimer.timeout.connect(PollInput)
	pass # Replace with function body.


func _process(_delta):
	PollInput()

func PollInput():
	if Input.is_action_just_pressed("Tilt_positive") :
		tiltPositive()
	if Input.is_action_just_pressed("Tilt_negative") :
		tiltNegative()
		
	## DEBUG BINDS
	#if Input.is_action_just_pressed("Debug_increaseGameSpeed"):
		#Globals.increaseGameSpeedBy(Globals.gameSpeedIncrease_interval)
	#if Input.is_action_just_pressed("Debug_decreaseGameSpeed"):
		#Globals.increaseGameSpeedBy(-Globals.gameSpeedIncrease_interval)

func tiltPositive():
	if !Globals.GameIsOver:
		Signals.pi_tiltPositive.emit()
func tiltNegative():
	if !Globals.GameIsOver:
		Signals.pi_tiltNegative.emit()	
func restartGame():
	if Globals.GameIsOver:
		#print("RestartRequest")
		Signals.pi_restartGame.emit()
func musicToggle():
	#print("Toggled play music")
	Signals.pi_toggleMusic.emit()
