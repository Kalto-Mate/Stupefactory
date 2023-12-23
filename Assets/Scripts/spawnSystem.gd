extends Node2D
@export var spawnTimer : Timer
@export var Spawners: Array[Node2D]
@export var Walkers: Array[PackedScene]
var SpawnedWalkers: Array[PackedScene]
var pauseSpawning: bool = false

func _ready():
	spawnTimer.timeout.connect(spawnWalker)
	Signals.seeSawIsMoving.connect(pauseTimer)

func spawnWalker():
	var chosenWalkerID = randi() % Walkers.size()
	var chosenWalker : PackedScene = Walkers[chosenWalkerID]
	
	var chosenSpawnerID = randi() % Spawners.size()
	var chosenSpawner : Node2D = Spawners[chosenSpawnerID]
	
	print("Spawning walker type ",chosenWalkerID," at spawnPoint ", chosenSpawnerID)
	var newWalker = chosenWalker.instantiate()
	SpawnedWalkers.append(newWalker)
	newWalker.position = chosenSpawner.global_position
	add_sibling(newWalker)

func pauseTimer(state:bool):
	spawnTimer.paused = state

func despawnAllWalkers():
	for walker in SpawnedWalkers:
		walker.queue_free()
