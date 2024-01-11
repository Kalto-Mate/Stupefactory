extends Node
@export var AudioPlayer : AudioStreamPlayer2D

var gameSpeed_STORE : float = Globals.RESET_Game_Speed

var PlaybackSpeed : float
var SpeedChangeStep : float = 0.013
var SpeedChange_Tween : Tween
const TweenTime : float = 30
const gameOverTweenTime : float = 3

const RESET_PlaybackSpeed : float = 1
const gameOver_PlaybackSpeed: float = 0
const maxPlaybacklSpeed : float = 1.8
const minPlaybackSpeed : float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	setPlayBackSpeed(1)
	Signals.gameSpeedChanged.connect(gameSpeedChanged)

func setPlayBackSpeed(value: float):
	self.PlaybackSpeed = value
	self.AudioPlayer.pitch_scale = PlaybackSpeed
	
func reset():
	self.PlaybackSpeed = RESET_PlaybackSpeed
	self.AudioPlayer.pitch_scale = RESET_PlaybackSpeed

func gameSpeedChanged(input : float):
	if input > gameSpeed_STORE :
		gameSpeed_STORE = input
		increaseAudioSpeed()
	elif input == 0 :
		gameOverAudioSpeed()
	gameSpeed_STORE = input

func increaseAudioSpeed():
	var newSpeed = PlaybackSpeed + SpeedChangeStep
	newSpeed = clamp(newSpeed,minPlaybackSpeed,maxPlaybacklSpeed)
	if newSpeed > self.PlaybackSpeed: #We only change it upwards, ignoring decreases
		self.PlaybackSpeed = newSpeed
		_tweenAudioSpeed(newSpeed,TweenTime)

func gameOverAudioSpeed():
	_tweenAudioSpeed(gameOver_PlaybackSpeed,gameOverTweenTime)
	
func _tweenAudioSpeed(TargetSpeed:float,TimeFrame:float):
#Make sure to check if the tween already exists before creating a new one to avoid multiple instances
#of the property being changed
	if SpeedChange_Tween:
		SpeedChange_Tween.kill()
	SpeedChange_Tween = get_tree().create_tween()
	
	SpeedChange_Tween.tween_property(self.AudioPlayer,"pitch_scale",TargetSpeed,TimeFrame)
