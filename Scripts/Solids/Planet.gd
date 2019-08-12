extends Area2D

var screen_size
var score = 20

func _ready():
	screen_size = get_viewport_rect().size
	scale = Vector2(1.5, 1.5)
	
func _process(delta):
	position.y += 3
	if position.y > 700:
		queue_free()
		
func _on_Planet_area_entered(area):
	if area.get_name() == "Player":
		queue_free()
	if area.get_overlapping_areas():
		queue_free()
