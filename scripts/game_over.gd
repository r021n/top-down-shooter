extends Control

@onready var final_score: Label = $FinalScore
@onready var restart_button: Button = $RestartButton
@onready var menu_button: Button = $MenuButton

func _ready():
	final_score.text = "Score: " + str(Global.final_score)
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
