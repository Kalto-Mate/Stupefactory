extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Tilt_positive"):
		Signals.pi_tiltPositive.emit()
	if Input.is_action_just_pressed("Tilt_negative"):
		Signals.pi_tiltNegative.emit()
	pass
