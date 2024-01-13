extends Node
@export var leftTouchButton : Button
var leftTouchButton_STORE : bool = false
@export var rightTouchButton : Button
var rightTouchButton_STORE : bool = false
@export var restartTouchButton: Button
@export var musicTouchButton: Button

@export var playerInput : Node

func _ready():
	leftTouchButton.pressed.connect  (_touchTiltNegative)
	rightTouchButton.pressed.connect (_touchTiltPositive)
	restartTouchButton.pressed.connect(playerInput.restartGame)
	musicTouchButton.pressed.connect(playerInput.musicToggle)

func _touchTiltNegative():
	print("_touchTiltNegative")
	playerInput.tiltNegative()
func _touchTiltPositive():
	print("_touchTiltPositive")
	playerInput.tiltPositive()
