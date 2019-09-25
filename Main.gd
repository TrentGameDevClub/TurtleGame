extends Node2D

export (PackedScene) var Ring
var ring_resource = preload("res://Ring.tscn")
var ring
var spawn = Vector2(500,525)
var score = 0
var wind
var intensity = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	_new_Ring()

func _process(delta):
	$GUI/Numbers/Score.text = str(score)
	
	ring.intensity = intensity
	get_node("GUI/Numbers/Force").text = str(ring.intensity)
	print(ring.intensity)

func _input(event):
	if event.is_action("scroll_up"):
		intensity += 5
	elif event.is_action("scroll_down"):
		intensity -= 5

# Called when the ring hits the turtle
func _on_Ring_hit():
	score += 1
	
	_new_Ring()
	

func _on_Ring_oob():
	score = 0
	_new_Ring()

func _new_Ring():
	ring = ring_resource.instance()
	ring.set_position(spawn)
	print("spawn")
	self.add_child(ring)
	ring.connect("hit", self, "_on_Ring_hit")
	ring.connect("oob", self, "_on_Ring_oob")
	
	wind = rand_range(-1000, 1000)
	$GUI/Numbers/Wind.text = str(wind)
	
	ring.wind = Vector2(wind, 0)
	ring.intensity 
	