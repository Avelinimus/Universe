extends KinematicBody2D
export (int) var speed = 700
#var evolve = ['asteroid', 'meteor', 'planet', 'star', 'hole']
var target = Vector2(370, 535) # Start position
var velocity = Vector2()
var screen_size

func player_evolve():
	pass

func player_move():
	if Input.is_action_pressed('click'): # Rework for android
		target = get_global_mouse_position()
	
	velocity = (target - position).normalized() * speed
	#rotation = velocity.angle()
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)

func _ready():
	screen_size = get_viewport_rect().size

# warning-ignore:unused_argument
func _process(delta):
	player_move()
	
		
	position.x = clamp(position.x, 25, screen_size.x - 25)
	position.y = clamp(position.y, 25, screen_size.y - 25)
	