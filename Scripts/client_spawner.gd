extends Node3D


@export var time_between: float = 5.0


@onready var path_1 = $client_first/Path3D/PathFollow3D
@onready var path_2 = $client_second/Path3D2/PathFollow3D
@onready var path_3 = $client_third/Path3D3/PathFollow3D
@onready var path_4 = $client_forth/Path3D4/PathFollow3D
@onready var open_animation = $Door/DoorOpen/OpenAnimation


@onready var paths: Dictionary = {
	path_1: true,
	path_2: true,
	path_3: true,
	path_4: true
}


@onready var client = preload("res://Scenes/Client.tscn")
@onready var creak = $Door/Creak


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_client() # Replace with function body.


func generate_client():
	open_animation.play("Open")
	creak.play()
	var new_client = client.instantiate() as Client3D
	var chosen_path = choose_path()
	new_client.path = chosen_path
	chosen_path.add_child(new_client)
	new_client.spawner = self
	new_client.come_in()
	await get_tree().create_timer(time_between).timeout
	generate_client()


func choose_path():
	var available: Array = []
	for k in paths.keys():
		if paths[k]:
			available.append(k)
	var result = available.pick_random()
	paths[result] = false
	return result
