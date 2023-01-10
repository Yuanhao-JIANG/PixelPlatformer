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
#	$AnimatedSprite.frames = load("res://PlayerGreen.tres")
	$AnimatedSprite.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	velocity.y += FALL_ACCELERATION_UP
	
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if input.x:
		velocity.x = move_toward(velocity.x, input.x*MAX_SPEED, RUN_ACCELERATION)
		$AnimatedSprite.animation = "Run"
		$AnimatedSprite.flip_h = input.x > 0
	else:
		velocity.x = move_toward(velocity.x, 0, RUN_ACCELERATION)
		$AnimatedSprite.animation = "Idle"
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = JUMP_FORCE
	else:
		$AnimatedSprite.animation = "Jump"
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
		if velocity.y > 0:
			velocity.y += FALL_ACCELERATION_DOWN - FALL_ACCELERATION_UP
	
	var was_in_air = not is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor() and was_in_air:
		$AnimatedSprite.animation = "Land"
