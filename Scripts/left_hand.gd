extends Node3D

@export var SPEED = 1.0
@export var ACCELERATION = 3.0

var velocity = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_dir = Input.get_vector("A", "D", "W", "S")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity = lerp(velocity, direction * SPEED, ACCELERATION * delta)
	position = position + velocity * delta
