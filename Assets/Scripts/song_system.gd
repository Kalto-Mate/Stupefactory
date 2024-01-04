extends Node
@export var AudioPlayer : AudioStreamPlayer2D

var PlaybackSpeed : float
var SpeedChangeStep : float = 0.0294117

const RESET_PlaybackSpeed : float = 1
const maxPlaybacklSpeed : float = 1.5
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

func increaseAudioSpeed(input : float):
	var newSpeed = PlaybackSpeed + SpeedChangeStep
	newSpeed = clamp(newSpeed,RESET_PlaybackSpeed,maxPlaybacklSpeed)
	if newSpeed > self.PlaybackSpeed: #We only change it upwards, ignoring decreases
		setPlayBackSpeed(newSpeed)
