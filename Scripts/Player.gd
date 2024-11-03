extends Node3D


@onready var horizontal_timer = $HorizontalTimer
@onready var vertical_timer = $VerticalTimer


@export_group("Positions")
@export var POS_1: Marker3D = null
@export var POS_2: Marker3D = null
@export var POS_3: Marker3D = null
@export var POS_4: Marker3D = null
@onready var PosDict: Dictionary = {
	1: POS_1,
	2: POS_2,
	3: POS_3,
	4: POS_4
}

@export_group("Settings")
## How many units player moves when looks down.
@export var Y_DELTA: float = 1.0
## How fast player moves between positoins.
@export var HORIZONTAL_SPEED: float = 10.0
## How fast player moves up/down
@export var VERTICAL_SPEED: float = 10.0


var is_currently_up: bool = true

var horizontal_move_locked: bool = false
var vertical_move_locked: bool = false


func _ready():
	self.position = POS_2.position


func move_to(number: int):
	var new_position = PosDict[number].position.x
	var tween = create_tween()
	horizontal_move_locked = true
	vertical_move_locked = true
	tween.tween_property(self, "position:x", new_position, 1 / HORIZONTAL_SPEED)
	await tween.finished
	horizontal_timer.start()
	await horizontal_timer.timeout
	horizontal_move_locked = false
	vertical_move_locked = false


func switch_vertical():
	var new_position: float
	if is_currently_up:
		new_position = self.position.y - Y_DELTA
	else:
		new_position = self.position.y + Y_DELTA
	var tween = create_tween()
	horizontal_move_locked = true
	vertical_move_locked = true
	tween.tween_property(self, "position:y", new_position, 1 / VERTICAL_SPEED)
	await tween.finished
	vertical_timer.start()
	is_currently_up = !is_currently_up
	await vertical_timer.timeout
	horizontal_move_locked = false
	vertical_move_locked = false


func _unhandled_input(event):
	for n in [1, 2, 3, 4]:
		if event.is_action_pressed(str(n)) and not horizontal_move_locked:
			move_to(n)
	if event.is_action_pressed("Shift"):
		switch_vertical()
	if event.is_action_pressed("Esc"):
		get_tree().quit()
