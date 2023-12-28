extends Node
@export var PollTimer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	#PollTimer.timeout.connect(PollInput)
	pass # Replace with function body.


func _process(_delta):
	PollInput()

func PollInput():
	if Input.is_action_just_pressed("Tilt_positive"):
		Signals.pi_tiltPositive.emit()
	if Input.is_action_just_pressed("Tilt_negative"):
		Signals.pi_tiltNegative.emit()
