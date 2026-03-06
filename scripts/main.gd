extends Node2D

var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
var score: int = 0

@onready var spawn_timer: Timer = $SpawnTimer

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

func _on_spawn_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position = get_random_spawn_position()
	enemy.tree_exited.connect(func(): add_score(10))
	add_child(enemy)

func get_random_spawn_position() -> Vector2:
	var viewport_size = get_viewport_rect().size
	var side = randi() % 4
	var pos = Vector2.ZERO

	match side:
		0: # Atas
			pos = Vector2(randf_range(0, viewport_size.x), -50)
		1: # Bawah
			pos = Vector2(randf_range(0, viewport_size.x), viewport_size.y + 50)
		2: # Kiri
			pos = Vector2(-50, randf_range(0, viewport_size.y))
		3: # Kanan
			pos = Vector2(viewport_size.x + 50, randf_range(0, viewport_size.y))

	return pos

func add_score(points: int):
	score += points
	print("Score: ", score)
