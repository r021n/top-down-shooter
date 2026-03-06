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
