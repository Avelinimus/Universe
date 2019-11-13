extends Area2D

onready var Asteroids = preload("res://Scenes/Solid/Asteroid.tscn")
onready var Meteors = preload("res://Scenes/Solid/Meteor.tscn")
onready var Planets = preload("res://Scenes/Solid/Planet.tscn")
onready var Stars = preload("res://Scenes/Solid/Star.tscn")
onready var HUD = preload("res://Scenes/Menu + HUD/InGame/HUD.tscn")

export (int) var speed = 500
var evolve = ['Asteroid', 'Meteor', 'Planet', 'Star', '', '', '', '']
var evolve_level = {
	'n_1': 10,
	'n_2': 100,
	'n_3': 200,
	'n_4': 300, 
}
var alive = true
var start_timeout =  false
var score_evolve = 0
var score = 0
var n = 0
var count_evolve = 1
var target = Vector2(370, 535) # Start position
var velocity = Vector2()
var screen_size

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"n": n,
		"score_evolve" :score_evolve,
		"score": score,
		"position_x": position.x,
		"position_y": position.y,
		"StartGameTimer": $Start_game_timer.time_left,
		"BlackHoleTimer": $Black_hole_timer.time_left,
		"alive": alive
	}
	return save_dict

func border_screen(x1, x2, y1, y2):
	position.x = clamp(position.x, x1, screen_size.x - x2)
	position.y = clamp(position.y, y1, screen_size.y - y2)

func evolve_anim():
	if n == 0:
		$".".scale = Vector2(1, 1)
		$AnimatedSprite.animation = "Asteroid"
	elif n == 1:
		$AnimatedSprite.animation = "Meteor"
	elif n == 2:
		$AnimatedSprite.animation = "Planet"
	elif n == 3:
		$AnimatedSprite.animation = "Star"
	elif n == 4:
		border_screen(85, 85, 85, 85)
		$".".scale = Vector2(3, 3)
		$AnimatedSprite.animation = "Black_hole"

func death():
	alive = false
	$".".visible = false
	$".".speed = 0
	$".".collision_layer = false
	$".".collision_mask = false

func player_move(delta):
	if Input.is_action_pressed('click'): # Rework for android
		target = get_global_mouse_position()
	velocity = (target - position).normalized() * speed
	#rotation = velocity.angle()
	if (target - position).length() > 9:
		position += (velocity * delta)
	
func _ready():
	screen_size = get_viewport_rect().size
	Player.visible = true
	$Start_game_timer.start()
	
# warning-ignore:unused_argument
func _process(delta):
	border_screen(25, 25, 25, 25)
	evolve_anim()
	if $Start_game_timer.time_left <= 0:
		player_move(delta)
		
func _on_Player_area_entered(area):
	if evolve[n] in area.get_name() or evolve[n - 1] in area.get_name() \
	or evolve[n - 2] in area.get_name() or evolve[n - 3] in area.get_name() or evolve[n - 4] in area.get_name():
		if evolve[0] in area.get_name():
			score_evolve += Asteroids.instance().score * Player.count_evolve
			score += Asteroids.instance().score * Player.count_evolve
		if score_evolve >= evolve_level.get('n_1') * Player.count_evolve:
			n = 1
			if evolve[1] in area.get_name():
				score_evolve += Meteors.instance().score * Player.count_evolve
				score += Meteors.instance().score * Player.count_evolve
			if score_evolve >= evolve_level.get('n_2') * Player.count_evolve:
				n = 2
				if evolve[2] in area.get_name():
					score_evolve += Planets.instance().score * Player.count_evolve
					score += Planets.instance().score * Player.count_evolve
				if score_evolve >= evolve_level.get('n_3') * Player.count_evolve:
					n = 3
					if evolve[3] in area.get_name():
						score_evolve += Stars.instance().score * Player.count_evolve
						score += Stars.instance().score * Player.count_evolve
					if score_evolve >= evolve_level.get('n_4') * Player.count_evolve:
						n = 4
						if n == 4 and evolve_level.get('n_4') * Player.count_evolve <= score_evolve and (Stars.instance().score + evolve_level.get('n_4')) * Player.count_evolve >= score_evolve:
							$Black_hole_timer.start()
					# Black Hole up and return asteroid
			elif evolve[n + 1] in area.get_name():
				alive = false
				death()
		elif evolve[n + 2] in area.get_name() or evolve[n + 3] in area.get_name() :
			alive = false
			death()
	elif evolve[n + 1] in area.get_name() or evolve[n + 2] in area.get_name() or evolve[n + 3] in area.get_name():
		alive = false
		death()
	
func _on_Black_hole_timer_timeout():
	n = 0
	Player.count_evolve += 0.05
	score_evolve = 0
	$Black_hole_timer.stop()

func _on_Start_game_timer_timeout():
	$Start_game_timer.stop()
	start_timeout =  true
