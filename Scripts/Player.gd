extends Area2D

onready var Asteroids = preload("res://Scenes/Solid/Asteroid.tscn")
onready var Meteors = preload("res://Scenes/Solid/Meteor.tscn")
onready var Planets = preload("res://Scenes/Solid/Planet.tscn")
onready var Stars = preload("res://Scenes/Solid/Star.tscn")

export (int) var speed = 700
var evolve = 1
var score_evolve = 0
var count = 0
var target = Vector2(370, 535) # Start position
var velocity = Vector2()
var screen_size

func player_move(delta):
	if Input.is_action_pressed('click'): # Rework for android
		target = get_global_mouse_position()
	velocity = (target - position).normalized() * speed
	#rotation = velocity.angle()
	if (target - position).length() > 5:
		position += velocity * delta
	
func _ready():
	screen_size = get_viewport_rect().size

# warning-ignore:unused_argument
func _process(delta):
	player_move(delta)
	position.x = clamp(position.x, 25, screen_size.x - 25)
	position.y = clamp(position.y, 25, screen_size.y - 25)

func _on_Player_area_entered(area):
	if 'Asteroid' in area.get_name():
		if evolve == Asteroids.instance().evolve:
			count += 1
			print(count)
		else: 
			queue_free()
	elif 'Meteor' in area.get_name():
		print('Meteor')
	elif 'Planet' in area.get_name():
		print('Planet')
	elif 'Star' in area.get_name():
		print('Star')