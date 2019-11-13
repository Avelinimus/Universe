extends Node2D

# Declare member variables here. Examples:
# var a = 2
var screen_size
var spawn_count = 0
var rand = rand_seed(120)

onready var Star = preload("res://Scenes/Background/Stars.tscn")
onready var Asteroids = preload("res://Scenes/Solid/Asteroid.tscn")
onready var Meteors = preload("res://Scenes/Solid/Meteor.tscn")
onready var Planets = preload("res://Scenes/Solid/Planet.tscn")
onready var Stars = preload("res://Scenes/Solid/Star.tscn")


func rand_pos(object, y0, y1):
	object.position.x = int(rand_range(0, screen_size.x))
	object.position.y = int(rand_range(y0, y1))

func add_back_stars(): # Spawn star on background
	var star = Star.instance()
	rand_pos(star, 0, screen_size.y)
	add_child(star)

func add_asteroids(spawn): # Spawn asteroids on background
	var asteroids = Asteroids.instance()
	rand_pos(asteroids, -180, -1150)
	if spawn_count > spawn: # Spawn count of asteroids
		add_child(asteroids)

func add_meteors(spawn): # Spawn meteors on background
	var meteors = Meteors.instance()
	rand_pos(meteors, -160, -900)
	if spawn_count > spawn: # Spawn count of meteors
		add_child(meteors)

func add_planets(spawn): # Spawn planets on background
	var planets = Planets.instance()
	rand_pos(planets, -220, -900)
	if spawn_count > spawn: # Spawn count of planets
		add_child(planets)

func add_stars(spawn): # Spawn planets on background
	var stars = Stars.instance()
	rand_pos(stars, -150, -1160)
	if spawn_count > spawn: # Spawn count of planets
		add_child(stars)
		spawn_count = 0
	spawn_count += 1

func add_black_star():
	pass

func spawner():
	var rand = int(rand_range(0, 100))
	if 1 == rand:
		add_asteroids(0)
		add_meteors(1)
	elif 20 == rand:
		add_asteroids(1)
		add_planets(0)
	elif 45 == rand:
		add_meteors(0)
		add_asteroids(1)
	elif 40 == rand:
		add_stars(1)
	elif 60 == rand:
		add_asteroids(1)
		add_meteors(0)
		add_planets(1)
	elif 80 == rand:
		add_asteroids(1)
		add_meteors(0)
		add_planets(1)
	elif 85 == rand:
		add_meteors(0)
		add_stars(1)
	elif 90 == rand:
		add_asteroids(0)
		add_meteors(1)
		add_planets(0)
	elif 100 == rand:
		add_asteroids(1)
	add_back_stars()

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):

	spawner()
