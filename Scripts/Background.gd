extends Node2D

# Declare member variables here. Examples:
# var a = 2
var screen_size
var asteroids_count = 0
onready var Star = preload("res://Scenes/Background/Stars.tscn")
onready var Asteroids = preload("res://Scenes/Solid/Asteroid.tscn")


func add_star(): # Spawn star on background
	var star = Star.instance()
	star.position.x = int(rand_range(0, screen_size.x))
	star.position.y = int(rand_range(0, screen_size.y))
	add_child(star)
	
func add_asteroids(): # Spawn asteroids on background
	var asteroids = Asteroids.instance()
	asteroids.position.x = int(rand_range(0, screen_size.x))
	asteroids.position.y = int(rand_range(-50, -25))
	if asteroids_count > 60: # Spawn count of asteroids
		add_child(asteroids)
		asteroids_count = 0
	asteroids_count += 1
	print(asteroids_count)
	
	
func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	add_star()
	
	add_asteroids()
