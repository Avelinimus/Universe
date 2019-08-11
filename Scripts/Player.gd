extends Area2D

onready var Asteroids = preload("res://Scenes/Solid/Asteroid.tscn")
onready var Meteors = preload("res://Scenes/Solid/Meteor.tscn")
onready var Planets = preload("res://Scenes/Solid/Planet.tscn")
onready var Stars = preload("res://Scenes/Solid/Star.tscn")

export (int) var speed = 1100
var evolve = ['Asteroid', 'Meteor', 'Planet', 'Star','', '']
var score_evolve = 0
var n = 0
var target = Vector2(370, 535) # Start position
var velocity = Vector2()
var screen_size

func player_move(delta):
	if Input.is_action_pressed('click'): # Rework for android
		target = get_global_mouse_position()
	velocity = (target - position).normalized() * speed 
	#rotation = velocity.angle()
	if (target - position).length() > 11:
		position += (velocity * delta)
	
func _ready():
	screen_size = get_viewport_rect().size

# warning-ignore:unused_argument
func _process(delta):
	player_move(delta)
	position.x = clamp(position.x, 25, screen_size.x - 25)
	position.y = clamp(position.y, 25, screen_size.y - 25)

func _on_Player_area_entered(area):
	print(score_evolve)
	print(n)
	
	if evolve[n] in area.get_name() or evolve[n - 1] in area.get_name() \
	or evolve[n - 2] in area.get_name() or evolve[n - 3] in area.get_name():
		score_evolve += Asteroids.instance().score
		if score_evolve >= 550:
			n = 1
			score_evolve += Meteors.instance().score
			if score_evolve >= 4250:
				n = 2
				score_evolve += Planets.instance().score
				if score_evolve >= 15450:
					n = 3
					score_evolve += Stars.instance().score
					# Black Hole up and return asteroid
			elif evolve[n + 1] in area.get_name():
				queue_free()
		elif evolve[n + 2] in area.get_name() or evolve[n + 3] in area.get_name() :
			queue_free()
	elif evolve[n + 1] in area.get_name() or evolve[n + 2] in area.get_name() or evolve[n + 3] in area.get_name():
		queue_free()
		
	
