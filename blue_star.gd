extends KinematicBody2D

export var speed = 200
export var score = 0
export var evolve = 0
var screen_size



func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	velocity.y -= 1
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 25, screen_size.x - 25)