extends Node3D

@export var SPEED = 1.0
@export var ACCELERATION = 2.0
@export var DECCELERATION = 3.0
@export var SENSITIVITY = 0.0005
@export var PLAYER: Node3D

var velocity = Vector3(0, 0, 0)

@onready var target_position = position


func _input(event):
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("return") and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		target_position = target_position + Vector3(event.screen_relative.x, 0, event.screen_relative.y) * SENSITIVITY


func _process(delta: float) -> void:
	if !PLAYER.is_moving_horizontally:
#		var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
#		velocity = lerp(velocity, Vector3(mouse_velocity.x, 0, mouse_velocity.y) * SPEED, ACCELERATION * delta)
		position = lerp(position, target_position, delta)
		clamp_pos()

func clamp_pos():
	position.x = clamp(position.x, 0.05, 0.70)
	position.z = clamp(position.z, -1, -0.5)
