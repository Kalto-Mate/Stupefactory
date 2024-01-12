extends Node
@export var HealthBar : TextureProgressBar
@export var HpBar_animator : AnimationPlayer
var shakeHpBar_anim_name : String = "shake_hpBar"

@export var ScoreDisplay : Label
const numberOfScoreDigits : int = 6
var StringFormatter : String


func _ready():
	Signals.healthChanged.connect(UpdateHealthBar)
	Signals.scoreChanged.connect(UpdateScoreDisplay)
	StringFormatter = "%0" + str(numberOfScoreDigits) + "d"
	
func UpdateHealthBar(newValue: float):
	if HealthBar.value > newValue:
		HpBar_animator.play(shakeHpBar_anim_name)
	HealthBar.value = newValue

func UpdateScoreDisplay(newValue : int):
	#print("Score Changed to " + str(newValue))
	ScoreDisplay.text = StringFormatter % newValue
