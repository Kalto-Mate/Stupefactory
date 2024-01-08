extends Node
@export var AudioPlayer : AudioStreamPlayer2D

var PlaybackSpeed : float
var SpeedChangeStep : float = 0.013
var SpeedChange_Tween : Tween
const TweenTime : float = 10

const RESET_PlaybackSpeed : float = 1
const maxPlaybacklSpeed : float = 1.8
# Called when the node enters the scene tree for the first time.
func _ready():
	setPlayBackSpeed(1)
	Signals.gameSpeedChanged.connect(increaseAudioSpeed)

func setPlayBackSpeed(value: float):
	self.PlaybackSpeed = value
	self.AudioPlayer.pitch_scale = PlaybackSpeed
	
func reset():
	self.PlaybackSpeed = RESET_PlaybackSpeed
	self.AudioPlayer.pitch_scale = RESET_PlaybackSpeed

func increaseAudioSpeed(_input : float):
	var newSpeed = PlaybackSpeed + SpeedChangeStep
	newSpeed = clamp(newSpeed,RESET_PlaybackSpeed,maxPlaybacklSpeed)
	if newSpeed > self.PlaybackSpeed: #We only change it upwards, ignoring decreases
		self.PlaybackSpeed = newSpeed
		_tweenAudioSpeed(newSpeed)
		
func _tweenAudioSpeed(TargetSpeed:float):
#Make sure to check if the tween already exists before creating a new one to avoid multiple instances
#of the property being changed
	if SpeedChange_Tween:
		SpeedChange_Tween.kill()
	SpeedChange_Tween = get_tree().create_tween()
	
	SpeedChange_Tween.tween_property(self.AudioPlayer,"pitch_scale",TargetSpeed,TweenTime)
