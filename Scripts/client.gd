extends Node3D

@onready var head_sprite = $Head
@onready var body_sprite = $Body
@onready var hair_sprite = $Hair


func _select_character():
	var head_num = randi() % 5
	var body_num = randi() % 2
	var hair_num = randi() % 6
	
	var head_tex_path = "res://Resources/Sprites/Characters/Heads/head_%d.PNG"
	var body_tex_path = "res://Resources/Sprites/Characters/Bodies/body_%d.PNG"
	var hair_tex_path = "res://Resources/Sprites/Characters/Hairs/hair_%d.PNG"
	
	head_sprite.texture = load(head_tex_path % head_num)
	body_sprite.texture = load(body_tex_path % body_num)
	hair_sprite.texture = load(hair_tex_path % hair_num)

func _generate_order():
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_select_character()
	_generate_order()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
