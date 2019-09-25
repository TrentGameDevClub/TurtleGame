extends RigidBody2D

var velocity = Vector2()
var active = false
var locked = false
var shot = false
onready var sprite = get_node("RingSprite")
export var intensity = 400
signal hit


export var force = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0

func _process(delta):
	var lock = Input.is_action_just_pressed("space")
	var shoot = Input.is_action_just_pressed("backspace")
	
	var mouse_position = get_viewport().get_mouse_position()
	if !locked and lock:
		locked = true
	elif locked and lock:
		locked = false
	if !locked and !shot:
		force = (get_global_mouse_position() - get_node(".").get_position()).normalized() * intensity
		look_at(get_global_mouse_position())
	
	if shoot:
		apply_central_impulse(force)
		gravity_scale = 1.5
		print("shoot")
		shot = true
		

func _integrate_forces(state):
	#if shot:
		#apply_central_impulse(force)
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Ring_body_entered(body):
	print("hit")
	emit_signal("hit")
	queue_free()
