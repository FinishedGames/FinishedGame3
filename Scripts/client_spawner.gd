extends Node3D

@export var paths: Array[Node3D] = []


@onready var client = preload("res://Scenes/Client.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_client() # Replace with function body.

func generate_client():
	var new_client = client.instantiate() as Client3D
	var chosen_path = choose_path() as PathFollow3D
	new_client.path = chosen_path
	chosen_path.add_child(new_client)
	#new_client.position += Vector3(0,0.2,0)

	new_client.come_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass

func choose_path() -> Node3D:
	var r = randi()%4
	return paths[r]
