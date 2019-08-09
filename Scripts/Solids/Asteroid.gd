extends KinematicBody2D

var screen_size
var asteroid_evolve = 1
var velocity = Vector2(0, 200)

func _on_body_entered(delta): # when colide asteroids 
	var colider = move_and_collide(velocity * delta)
	if colider:
		queue_free()

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	_on_body_entered(delta)
	
	