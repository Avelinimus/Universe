extends KinematicBody2D

export var speed = 200
export var score = 0
export var evolve = 0
var screen_size



func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	# Movement for player
	var velocity = Vector2()
	print(int(rand_range(0,2)))
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	velocity = velocity.normalized() * speed
	# Clamp for player
	position += velocity * delta
	position.x = clamp(position.x, 25, screen_size.x - 25)
