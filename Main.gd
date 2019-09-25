extends Node2D

export (PackedScene) var Ring
var ring_resource = preload("res://Ring.tscn")
#var ring = ring_resource.instance()
var spawn = Vector2(500,525)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Ring_hit():
	var ring = ring_resource.instance()
	ring.set_position(spawn)
	print("spawn")
	self.add_child(ring)
	ring.connect("hit", self, "_on_Ring_hit")
	ring.connect("hit", $GUI, "_on_Ring_hit")