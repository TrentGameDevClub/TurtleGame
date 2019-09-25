extends RigidBody2D

var active = false
var locked = false
var shot = false
onready var sprite = get_node("RingSprite")
export var intensity = 500
signal hit
signal oob
export var force = Vector2()
export var wind = Vector2(200, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0 # Don't want it to fall before being shot

# Every frame
func _process(delta):
	# inputs
	var lock = Input.is_action_just_pressed("space")
	var shoot = Input.is_action_just_pressed("backspace")
	var increase = Input.is_action_pressed("scroll_up")
	var decrease = Input.is_action_pressed("scroll_down")
	
	# look at mouse when space hasn't been pressed, lets you unlock by hitting space again, backspace shoots it
	var mouse_position = get_viewport().get_mouse_position()
	if !locked and lock:
		locked = true
	elif locked and lock:
		locked = false
	if !locked and !shot:
		force = (get_global_mouse_position() - get_node(".").get_position()).normalized() * intensity
		look_at(get_global_mouse_position())
	
	
	# impulse on ring, turn on gravity, can't shoot after it's shot
	if shoot and !shot:
		apply_central_impulse(force)
		gravity_scale = 1.5
		print("shoot")
		shot = true
		

# Does physics math
func _integrate_forces(state):
	if shot:
		applied_force = wind
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# When the ring hits the turtle emit signal and delete self, when it hits the walls it just respawns
func _on_Ring_body_entered(body):
	
	print(body.get_instance_id())
	var id = 1151
	if body.get_instance_id() == id:
		print("hit turtle")
		emit_signal("hit")
	else:
		print("Out of bounds")
		emit_signal("oob")
	queue_free()
