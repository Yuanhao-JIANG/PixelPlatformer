extends KinematicBody2D

export var MAX_SPEED = 90
export var RUN_ACCELERATION = 30
export var JUMP_FORCE = -140
export var JUMP_RELEASE_FORCE = -30
export var FALL_ACCELERATION_UP = 5
export var FALL_ACCELERATION_DOWN = 10
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	velocity.y += FALL_ACCELERATION_UP
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x, MAX_SPEED, RUN_ACCELERATION)
	elif Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, -1*MAX_SPEED, RUN_ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, RUN_ACCELERATION)
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
		if velocity.y > 0:
			velocity.y += FALL_ACCELERATION_DOWN - FALL_ACCELERATION_UP
	
	velocity = move_and_slide(velocity, Vector2.UP)
