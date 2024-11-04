class_name  Client3D extends Node3D

@onready var head_sprite = $Head
@onready var body_sprite = $Body
@onready var hair_sprite = $Hair

var path : PathFollow3D


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


func come_in() -> void:
	var start_rotation = rotation
	var start_position = position
	var p = 0
	var tree = get_tree()
	var speed = randf()/4+0.5
	await tree.create_timer(2).timeout
	while (p<1):
		p+=get_process_delta_time()*speed;
		if p>1:
			p = 1.0
		rotation = start_rotation + Vector3(0,0,0.2*sin(4*PI*p))
		position = start_position + Vector3(0,p/5+0.2+0.2*sin(8*PI*p-PI/2),0)
		path.progress_ratio = p
		await tree.process_frame
	await tree.create_timer(2).timeout
	leave()
		


func leave() -> void:
	var start_rotation = rotation
	
	var p = 0.0
	var tree = get_tree()
	var speed = 0.6
	await tree.create_timer(2).timeout
	while (p<1):
		p+=get_process_delta_time()*speed;
		if p>1:
			p = 1.0
		rotation = start_rotation + Vector3(0,0,0.2*p*sin(4*PI*p))
		await tree.process_frame
	p = 0.0
	start_rotation = rotation
	while (p<1):
		p+=get_process_delta_time()*speed;
		if p>1:
			p = 1.0
		rotation = start_rotation + Vector3(4*p*p,0,0.2*(1-p)*sin((4-2*p)*PI*p))
		await tree.process_frame
		
		
	
	
