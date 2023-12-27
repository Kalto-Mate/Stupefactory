extends Node2D
@export var spawnTimer : Timer
@export var Spawners: Array[Node2D]
@export var ItemPrefab: PackedScene
var SpawnedItems: Array[PackedScene]
var pauseSpawning: bool = false

func _ready():
	spawnTimer.timeout.connect(spawnWalker)
	#Signals.seeSawIsMoving.connect(pauseTimer)

func spawnWalker():
	
	var chosenSpawnerID = randi() % Spawners.size()
	var chosenSpawner : Node2D = Spawners[chosenSpawnerID]
	
	#print("Spawning walker type ",chosenWalkerID," at spawnPoint ", chosenSpawnerID)
	var newItem = ItemPrefab.instantiate()
	SpawnedItems.append(newItem)
	newItem.position = chosenSpawner.global_position
	add_sibling(newItem)

func pauseTimer(state:bool):
	spawnTimer.paused = state

func despawnAllWalkers():
	for Item in SpawnedItems:
		Item.queue_free()
