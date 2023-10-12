extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _ready():
	$SelfDestructTimer.start()

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if "hit" in body: ##if body.has_method("hit") but with attributes, not just methods
		body.hit()
	queue_free()

func _on_timer_timeout():
	queue_free()
