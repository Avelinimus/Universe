extends Area2D

var screen_size
var score = 40

func _ready():
	screen_size = get_viewport_rect().size
	scale = Vector2(2, 2)

func _process(delta):
	position.y += 3 * Player.count_evolve
	if position.y > screen_size.y + 50:
		queue_free()
		
func _on_Star_area_entered(area):
	if area.get_name() == "Player":
		queue_free()
	if area.get_overlapping_areas():
		queue_free()
