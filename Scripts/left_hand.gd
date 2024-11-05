extends Node3D

@export var SPEED: float = 1.0
@export var ACCELERATION: float = 3.0
@export var PLAYER: Node3D


var velocity = Vector3(0, 0, 0)


func _process(delta: float) -> void:
	if !PLAYER.is_moving_horizontally:
		var input_dir = Input.get_vector("A", "D", "W", "S")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		velocity = lerp(velocity, direction * SPEED, ACCELERATION * delta)
		position = position + velocity * delta
		clamp_pos()


func clamp_pos():
	position.x = clamp(position.x, -0.75, -0.10)
	position.z = clamp(position.z, -1, -0.5)
