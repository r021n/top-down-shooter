extends CharacterBody2D

@export var speed: float = 300.0
@export var fire_rate: float = 0.2
@export var max_hp: int = 100

var hp: int = max_hp
var can_shoot: bool = true
var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")

func _physics_process(_delta):
	var input = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		input.y -= 1
	if Input.is_action_pressed("ui_down"):
		input.y += 1
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_pressed("ui_right"):
		input.x += 1
	
	input = input.normalized()
	velocity = input * speed
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()

func shoot():
	can_shoot = false
	
	var bullet = bullet_scene.instantiate()
	var muzzle = $Muzzle
	
	bullet.position = muzzle.global_position
	bullet.direction = (get_global_mouse_position() - muzzle.global_position).normalized()
	bullet.rotation = bullet.direction.angle()
	
	get_parent().add_child(bullet)
	
	var timer = get_tree().create_timer(fire_rate)
	timer.timeout.connect(func(): can_shoot = true)

func take_damage(damage: int):
	hp -= damage
	print("Player HP: ", hp)
	
	if hp <= 0:
		die()	

func die():
	print("Player Mati!")
	queue_free()
