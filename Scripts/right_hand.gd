extends Node3D

@export var SPEED = 2.0
@export var SENSITIVITY = 0.0005

@export var far_left = Vector3(-0.3, -1, -1.3)
@export var near_right = Vector3(0.7, 1, -0.3)


@onready var target_position = position

func _input(event):
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("return") and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		target_position = target_position + Vector3(event.screen_relative.x, 0, event.screen_relative.y) * SENSITIVITY
		print(target_position)
		target_position = target_position.clamp(far_left, near_right)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = lerp(position, target_position, delta * SPEED)
