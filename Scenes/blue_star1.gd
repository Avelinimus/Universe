extends KinematicBody2D

export var speed = 200
export var score = 0
export var evolve = 0
var screen_size

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	velocity.y += 1
	velocity = velocity.normalized() * speed



