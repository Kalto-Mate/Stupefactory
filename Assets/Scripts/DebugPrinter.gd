extends Label

func _ready():
	Signals.debugPrint.connect(displayMessage)

func displayMessage(Message:String):
	self.text = Message
