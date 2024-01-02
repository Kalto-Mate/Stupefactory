extends Node
@export var spawnTimer : Timer
const baseSpawnInterval : float = 7
@export var Spawners: Array[Node2D]
@export var ItemPrefab: PackedScene
var SpawnedItems: Array[ItemClass]
var pauseSpawning: bool = false

func _ready():
	spawnTimer.timeout.connect(spawnWalker)
	spawnTimer.wait_time = baseSpawnInterval
	
	Signals.gameSpeedChanged.connect(_updateSpawnTimer)

func spawnWalker():
	
	var chosenSpawnerID = randi() % Spawners.size()
	var chosenSpawner : Node2D = Spawners[chosenSpawnerID]
	
	#print("Spawning walker type ",chosenWalkerID," at spawnPoint ", chosenSpawnerID)
	var newItem = ItemPrefab.instantiate()
	SpawnedItems.append(newItem)
	newItem.global_position = chosenSpawner.global_position
	add_sibling(newItem)

func _updateSpawnTimer(newGameSpeed:float):
	spawnTimer.wait_time = baseSpawnInterval / newGameSpeed

func pauseTimer(state:bool):
	spawnTimer.paused = state

func despawnAllWalkers():
	for Item in SpawnedItems:
		Item.queue_free()
