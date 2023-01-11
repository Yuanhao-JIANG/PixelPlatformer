extends KinematicBody2D


export var speed = 20
var velocity = Vector2(speed, 0)


func _physics_process(_delta):
	velocity.y += 10
	if is_on_wall() or not $EdgeCheckerL.is_colliding() or not $EdgeCheckerR.is_colliding():
		velocity.x *= -1
	velocity.y = move_and_slide(velocity, Vector2.UP).y
