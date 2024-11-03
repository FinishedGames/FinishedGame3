extends Node3D

@export_group("Positions")
@export var POS_1: Marker3D = null
@export var POS_2: Marker3D = null
@export var POS_3: Marker3D = null
@export var POS_4: Marker3D = null

@onready var client = preload("res://Scripts/client.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func generate_client():
	var new_client = client.instance()
	add_child(new_client)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
