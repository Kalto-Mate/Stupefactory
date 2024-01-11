extends Node
@export var spawnTimer : Timer
const baseSpawnInterval : float = 7
const failureChance : int = 10
@export var Spawners: Array[SpawnerClass]

var pauseSpawning: bool = false

func _ready():
	spawnTimer.timeout.connect(spawnWalker)
	spawnTimer.wait_time = baseSpawnInterval
	
	Signals.gameSpeedChanged.connect(_updateSpawnTimer)

func spawnWalker():
	var failureRoll : int = randi_range(1,100)
	if failureChance <= failureRoll :
		var SeeSawPosOfset = Globals.seeSawPosition + 1 #By doing this we go from (-1,0,1) to (0,1,2) 
		#Assuming the spawners are in order top to bottom, we reduce the number of choices with substraction
		#Thus, a SeeSawPosOfset of 2 means only the top spawner will be elligible, while one of 0 means all are
		var chosenSpawnerID = randi() % (Spawners.size() - SeeSawPosOfset)
		var chosenSpawner : Node2D = Spawners[chosenSpawnerID]
		chosenSpawner.spawnItem()
	
	#print("Spawning walker type ",chosenWalkerID," at spawnPoint ", chosenSpawnerID)

func _updateSpawnTimer(newGameSpeed:float):
	if newGameSpeed == 0:
		spawnTimer.paused = true
	else:
		var newTime = baseSpawnInterval / newGameSpeed
		spawnTimer.wait_time = clamp(newTime,Globals.minSpawnSpeed,100)
	#print("spawnTimer.wait_time: " ,spawnTimer.wait_time)
