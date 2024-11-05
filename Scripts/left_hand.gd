extends Node3D

@export var SPEED = 1.0
@export var ACCELERATION = 2.0

@export var far_left = Vector3(-0.7, -1, -1.3)
@export var near_right = Vector3(0.3, 1, -0.3)

var velocity = Vector3(0, 0, 0)

func check_box(hand_pos : Vector3) -> bool:
	var in_box = hand_pos.z <= -0.3 and hand_pos.z >= -1.3 and hand_pos.x >= -0.8 and hand_pos.x <= 0
	return in_box

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_dir = Input.get_vector("A", "D", "W", "S")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity = lerp(velocity, direction * SPEED, ACCELERATION * delta)
	position = position + velocity * delta
	position = position.clamp(far_left, near_right)
