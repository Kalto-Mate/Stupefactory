extends Area2D

func _ready():
	self.body_entered.connect(bodyEntered)

func bodyEntered(body: Node2D):
	body.queue_free()
	Signals.ItemFell.emit()
