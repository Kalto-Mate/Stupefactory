extends AnimatableBody2D

var SeeSaw_tween: Tween

var PositionIndex: int = 0
var MaxPositionIndex: int = 1
var MinPositionIndex: int = -1

@export var StepTime:float = .1
var platformMaxAbsAngle: float = 30

func _ready():
	Signals.pi_tiltPositive.connect(_tiltPositive)
	Signals.pi_tiltNegative.connect(_tiltNegative)

func _tiltPositive():
	_tilt(1)
func _tiltNegative():
	_tilt(-1)

func _tilt(direction: int):
	var NewPositionIndex = PositionIndex + direction
	NewPositionIndex = clamp(NewPositionIndex,MinPositionIndex,MaxPositionIndex)
	PositionIndex = NewPositionIndex
	_tweenToAngle(PositionIndex*platformMaxAbsAngle)

func _tweenToAngle(TargetAngle:float):
#Make sure to check if the tween already exists before creating a new one to avoid multiple instances
#of the property being changed
	if SeeSaw_tween:
		SeeSaw_tween.kill()
	SeeSaw_tween = get_tree().create_tween()
	var AbsAngleDelta = abs(self.rotation_degrees - TargetAngle)
	var adjustedTime = (AbsAngleDelta*StepTime) / platformMaxAbsAngle
	SeeSaw_tween.tween_property(self,"rotation_degrees",TargetAngle,adjustedTime)
