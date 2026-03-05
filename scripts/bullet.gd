extends Area2D

@export var speed: float = 600.0

var direction: Vector2 = Vector2.ZERO

func _ready():
	var timer = get_tree().create_timer(3.0)
	timer.timeout.connect(queue_free)
	
func _physics_process(delta):
	position += direction * speed * delta
