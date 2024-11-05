extends Node3D


@onready var horizontal_timer: Timer = $HorizontalTimer
@onready var vertical_timer: Timer = $VerticalTimer
@onready var left_hand: Node3D = $LeftHand
@onready var right_hand: Node3D = $RightHand

@onready var woosh: AudioStreamPlayer3D = $Woosh
@onready var grunt: AudioStreamPlayer3D = $Grunt


@export var current_pos: int = 2

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
## How many units player moves their hands when moving up/down
@export var Z_HAND_TEMP_POS: float = -0.2
## How fast player moves their hands when moving up/down.
@export var Z_HAND_SPEED: float = 10.0


var is_currently_up: bool = true

var horizontal_move_locked: bool = false
var vertical_move_locked: bool = false


func _ready():
	self.position = PosDict[current_pos].position


func move_to(number: int):
	
	if number == current_pos:
		return
	
	woosh.play()
	
	var new_position = PosDict[number].position.x
	var halfway = self.position.x + (PosDict[number].position.x - self.position.x) / 2
	
	var left_hand_pos = left_hand.position.z
	var left_hand_temp_pos = Z_HAND_TEMP_POS
	
	var right_hand_pos = right_hand.position.z
	var right_hand_temp_pos = Z_HAND_TEMP_POS
	
	var first_tween = create_tween()
	
	horizontal_move_locked = true
	vertical_move_locked = true
	
	first_tween.tween_property(self, "position:x", halfway, 1 / HORIZONTAL_SPEED)
	if not is_currently_up:
		var first_left_hand_tween = create_tween()
		var first_right_hand_tween = create_tween()
		first_left_hand_tween.tween_property(left_hand, "position:z", left_hand_temp_pos, 1 / Z_HAND_SPEED)
		first_right_hand_tween.tween_property(right_hand, "position:z", right_hand_temp_pos, 1 / Z_HAND_SPEED)
		await first_right_hand_tween.finished
	else:
		await first_tween.finished
	
	var second_tween = create_tween()
	
	
	second_tween.tween_property(self, "position:x", new_position, 1 / VERTICAL_SPEED)
	if not is_currently_up:
		var second_left_hand_tween = create_tween()
		var second_right_hand_tween = create_tween()
		second_left_hand_tween.tween_property(left_hand, "position:z", left_hand_pos, 1 / Z_HAND_SPEED)
		second_right_hand_tween.tween_property(right_hand, "position:z", right_hand_pos, 1 / Z_HAND_SPEED)
		await second_right_hand_tween.finished
	else:
		await second_tween.finished
	
	horizontal_timer.start()
	await horizontal_timer.timeout
	horizontal_move_locked = false
	vertical_move_locked = false
	
	current_pos = number


func switch_vertical():
	grunt.play()
	
	var new_position: float
	var halfway: float
	if is_currently_up:
		new_position = self.position.y - Y_DELTA
		halfway = self.position.y - Y_DELTA / 2
	else:
		new_position = self.position.y + Y_DELTA
		halfway = self.position.y + Y_DELTA / 2
	var first_tween = create_tween()
	var first_left_hand_tween = create_tween()
	var first_right_hand_tween = create_tween()
	
	var left_hand_pos = left_hand.position.z
	var left_hand_temp_pos = Z_HAND_TEMP_POS
	
	var right_hand_pos = right_hand.position.z
	var right_hand_temp_pos = Z_HAND_TEMP_POS
	
	horizontal_move_locked = true
	vertical_move_locked = true
	
	first_tween.tween_property(self, "position:y", halfway, 1 / VERTICAL_SPEED)
	first_left_hand_tween.tween_property(left_hand, "position:z", left_hand_temp_pos, 1 / Z_HAND_SPEED)
	first_right_hand_tween.tween_property(right_hand, "position:z", right_hand_temp_pos, 1 / Z_HAND_SPEED)
	
	if VERTICAL_SPEED > Z_HAND_SPEED:
		await first_right_hand_tween.finished
	else:
		await first_tween.finished
	
	var second_tween = create_tween()
	var second_left_hand_tween = create_tween()
	var second_right_hand_tween = create_tween()
	
	second_tween.tween_property(self, "position:y", new_position, 1 / VERTICAL_SPEED)
	second_left_hand_tween.tween_property(left_hand, "position:z", left_hand_pos, 1 / Z_HAND_SPEED)
	second_right_hand_tween.tween_property(right_hand, "position:z", right_hand_pos, 1 / Z_HAND_SPEED)
	
	if VERTICAL_SPEED > Z_HAND_SPEED:
		await second_right_hand_tween.finished
	else:
		await second_tween.finished
	
	is_currently_up = !is_currently_up
	vertical_timer.start()
	await vertical_timer.timeout
	horizontal_move_locked = false
	vertical_move_locked = false


func _unhandled_input(event):
	for n in [1, 2, 3, 4]:
		if event.is_action_pressed(str(n)) and not horizontal_move_locked:
			move_to(n)
	if event.is_action_pressed("Shift") and not vertical_move_locked:
		switch_vertical()
#	if event.is_action_pressed("Esc"):
#		get_tree().quit()
