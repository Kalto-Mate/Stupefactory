extends Node
@export var HealthBar : TextureProgressBar

@export var ScoreDisplay : Label
const numberOfScoreDigits : int = 6
var StringFormatter : String

func _ready():
	Signals.healthChanged.connect(UpdateHealthBar)
	Signals.scoreChanged.connect(UpdateScoreDisplay)
	StringFormatter = "%0" + str(numberOfScoreDigits) + "d"
	
func UpdateHealthBar(newValue: float):
	HealthBar.value = newValue

func UpdateScoreDisplay(newValue : int):
	#print("Score Changed to " + str(newValue))
	ScoreDisplay.text = StringFormatter % newValue
