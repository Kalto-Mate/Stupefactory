extends StaticBody2D

@export var maxTiltingDeg: float = 30
var maxTiltingRad:float
@export var tiltStepDeg: float = 15
var tiltStepRad:float

# Called when the node enters the scene tree for the first time.
func _ready():
	maxTiltingRad = deg_to_rad(maxTiltingDeg)
	tiltStepRad = deg_to_rad(tiltStepDeg)
	
	Signals.pi_tiltPositive.connect(_tiltPositive)
	Signals.pi_tiltNegative.connect(_tiltNegative)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _tilt(tiltAmmount:float):
	var newAngle: float = self.rotation + tiltAmmount
	var clampedNewAngle: float = clamp(newAngle,-maxTiltingRad,maxTiltingRad)
	self.rotation = clampedNewAngle

func _tiltPositive():
	_tilt(tiltStepRad)
func _tiltNegative():
	_tilt(-1 * tiltStepRad)
