extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -600.0
const ACCELERATION = 0.1
const DECELERATION = 0.1

@onready var gc := $GrappleController

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") && (is_on_floor() || gc.launched):
		velocity.y += JUMP_VELOCITY
		gc.retract()
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = lerp(velocity.x, SPEED * direction, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0.0, DECELERATION)
	
	move_and_slide()
