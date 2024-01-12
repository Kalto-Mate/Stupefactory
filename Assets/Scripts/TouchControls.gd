extends Node
@export var leftTouchButton : Button
var leftTouchButton_STORE : bool = false
@export var rightTouchButton : Button
var rightTouchButton_STORE : bool = false
@export var restartTouchButton: Button

@export var playerInput : Node

func _ready():
	leftTouchButton.pressed.connect(playerInput.tiltNegative)
	rightTouchButton.pressed.connect(playerInput.tiltPositive)
	restartTouchButton.pressed.connect(playerInput.restartGame)
