extends Node2D

var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
var score: int = 0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var score_label: Label = $UI/ScoreLabel
@onready var player: CharacterBody2D = $Player

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	player.global_position = get_viewport_rect().size / 2

func _process(_delta):
	if player == null:
		game_over()

func _on_spawn_timer_timeout():
	spawn_enemy()
	
	if spawn_timer.wait_time > 0.5:
		spawn_timer.wait_time -= 0.05

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
	score_label.text = "Score: " + str(score)
	
func game_over():
	spawn_timer.stop()
	Global.final_score = score
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
