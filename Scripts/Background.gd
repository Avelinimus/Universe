extends Node2D

# Declare member variables here. Examples:
# var a = 2
var screen_size
var timer = 0
onready var Star = preload("res://Scenes/Background/Stars.tscn")

func add_star(): # Spawn star on background
	var star = Star.instance()
	star.position.x = int(rand_range(0, screen_size.x))
	star.position.y = int(rand_range(0, screen_size.y))
	add_child(star)

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	add_star()
