extends KinematicBody2D

const GRAVITY = 500.0
const MAX_SPEED = 200

var velocity = Vector2()
var active = false
var locked = false
var shot = false
onready var sprite = get_node("RingSprite")

func _physics_process(delta):
	var lock = Input.is_action_just_pressed("space")
	var shoot = Input.is_action_just_pressed("backspace")
	var force = Vector2(0, GRAVITY)
	var mouse_position = get_viewport().get_mouse_position()
	
	if !locked and lock:
		locked = true
	elif locked and lock:
		locked = false
	if !locked:
			sprite.rotation = (mouse_position - sprite.global_position).angle()
	
	if shoot:
		shot = true
	if shot:
		move_and_slide(force)