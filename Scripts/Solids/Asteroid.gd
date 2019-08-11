extends Area2D

var screen_size
var evolve = 1
var score = 10

func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	position.y += 3
	if position.y > 700:
		queue_free()

func _on_Asteroid_area_entered(area):
	if area.get_overlapping_areas():
		queue_free()
	if area.get_name() == "Player":
		queue_free()





