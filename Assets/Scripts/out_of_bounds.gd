extends Area2D
@export var audioPlayer: AudioStreamPlayer
@export var CrashSounds: Array[AudioStream]
func _ready():
	self.body_entered.connect(bodyEntered)

func bodyEntered(body: Node2D):
	body.queue_free()
	Signals.ItemFell.emit()
	var randomSound:AudioStream = CrashSounds.pick_random()
	audioPlayer.stream = randomSound
	audioPlayer.play()
