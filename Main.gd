extends Node2D

export (PackedScene) var Ring
var ring_resource = preload("res://Ring.tscn")
var ring
var spawn = Vector2(500,525)
var score = 0
var wind
var intensity = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	_new_Ring()

func _process(delta):
	get_node("GUI/HBox/Left/Score").text = str(score)
	
	ring.intensity = intensity
	get_node("GUI/HBox/Left/Force").text = str(ring.intensity)
	get_node("GUI/HBox/Left/ForceBar").set_value(intensity)
	

func _input(event):
	if event.is_action("scroll_up") and intensity < 800:
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
	get_node("GUI/HBox/Right/Wind").text = str(wind)
	
	if(wind < 0):
		get_node("GUI/HBox/Right/Sprite").set_flip_h(true)
	else:
		get_node("GUI/HBox/Right/Sprite").set_flip_h(false)
	
	ring.wind = Vector2(wind, 0)
	get_node("GUI/HBox/Right/WindBar").set_value(abs(wind))
	ring.intensity 
	