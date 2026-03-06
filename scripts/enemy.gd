extends CharacterBody2D

@export var speed: float = 150.0
@export var max_hp: int = 30
@export var damage: int = 10
@export var attack_cooldown: float = 1.0

var hp: int = max_hp
var player: Node2D = null
var can_attack: bool = true

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if player == null:
		return

	look_at(player.global_position)

	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

	# Cek jarak ke player, kalau dekat → serang
	var distance = global_position.distance_to(player.global_position)
	if distance < 60 and can_attack:
		attack()

func attack():
	can_attack = false
	if player and player.has_method("take_damage"):
		player.take_damage(damage)

	var timer = get_tree().create_timer(attack_cooldown)
	timer.timeout.connect(func(): can_attack = true)

func take_damage(damage_amount: int):
	hp -= damage_amount
	print("Enemy HP: ", hp)

	if hp <= 0:
		die()

func die():
	queue_free()
