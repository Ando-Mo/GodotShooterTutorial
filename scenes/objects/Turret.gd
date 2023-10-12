extends CharacterBody2D
var speed = 400;

func _process(delta):
	#direction
	var direction = Vector2.RIGHT
	#velocity
	velocity = direction * speed
	#move and slide
	move_and_slide()

func hit():
	print('ouch')
