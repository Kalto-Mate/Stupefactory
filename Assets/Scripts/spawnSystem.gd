extends Node
@export var spawnTimer : Timer
const baseSpawnInterval : float = 7
@export var Spawners: Array[SpawnerClass]

var pauseSpawning: bool = false

func _ready():
	spawnTimer.timeout.connect(spawnWalker)
	spawnTimer.wait_time = baseSpawnInterval
	
	Signals.gameSpeedChanged.connect(_updateSpawnTimer)

func spawnWalker():
	
	var chosenSpawnerID = randi() % Spawners.size()
	var chosenSpawner : Node2D = Spawners[chosenSpawnerID]
	chosenSpawner.spawnItem()
	
	#print("Spawning walker type ",chosenWalkerID," at spawnPoint ", chosenSpawnerID)

func _updateSpawnTimer(newGameSpeed:float):
	spawnTimer.wait_time = baseSpawnInterval / newGameSpeed
	print("spawnTimer.wait_time: " ,spawnTimer.wait_time)
