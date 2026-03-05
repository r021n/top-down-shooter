extends CharacterBody2D

@export var speed: float = 300.0

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
