extends AnimatableBody2D

var SeeSaw_tween: Tween

var PositionIndex: int = 0
var MaxPositionIndex: int = 1
var MinPositionIndex: int = -1

@export var StepTime:float = .1
@export var soundPlayer : AudioStreamPlayer

@export var positiveSound : AudioStream
@export var negativeSound : AudioStream
@export var stuckSound : AudioStream

var platformMaxAbsAngle: float = 30

func _ready():
	Signals.pi_tiltPositive.connect(_tiltPositive)
	Signals.pi_tiltNegative.connect(_tiltNegative)

func _tiltPositive():
	_tilt(1)
func _tiltNegative():
	_tilt(-1)

func _tilt(direction: int):
	_playSound(direction)
	var NewPositionIndex = PositionIndex + direction
	NewPositionIndex = clamp(NewPositionIndex,MinPositionIndex,MaxPositionIndex)
	PositionIndex = NewPositionIndex
	Signals.seeSawChangedPosition.emit(PositionIndex)
	_tweenToAngle(PositionIndex*platformMaxAbsAngle)

func _tweenToAngle(TargetAngle:float):
#Make sure to check if the tween already exists before creating a new one to avoid multiple instances
#of the property being changed
	if SeeSaw_tween:
		SeeSaw_tween.kill()
	SeeSaw_tween = get_tree().create_tween()
	
	var AbsAngleDelta = abs(self.rotation_degrees - TargetAngle)
	var adjustedTime = (AbsAngleDelta*StepTime) / platformMaxAbsAngle
	
	Signals.seeSawIsMoving.emit(true)
	SeeSaw_tween.tween_property(self,"rotation_degrees",TargetAngle,adjustedTime)
	SeeSaw_tween.finished.connect(_seeSawStoppedMoving)
	
func _seeSawStoppedMoving():
	Signals.seeSawIsMoving.emit(false)
	pass

func _playSound(direction:int):
	#Assumed 3 sounds loaded in "negative", "stuck" and "positive" order
	var movement:int = PositionIndex + direction
	
	if abs(movement) == 2 : #If we try to move past (-1,0,1)
		soundPlayer.stream = stuckSound
	elif direction > 0:
		soundPlayer.stream = positiveSound
	elif direction < 0:
		soundPlayer.stream = negativeSound
			
	soundPlayer.play()
