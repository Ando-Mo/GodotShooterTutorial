extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laserShot(pos, direction)
signal grenadeShot(pos, direction)

@export var max_speed: int = 500
var speed: int = max_speed


func _process(_delta):
	#movement
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide() #automatically uses Delta
	
	#rotate 
	look_at(get_global_mouse_position())
	
	#laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$LaserParticles.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		var player_direction = (get_global_mouse_position() - position).normalized()
		$LaserTimer.start()
		laserShot.emit(selected_laser.global_position, player_direction)
		can_laser = false
	
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		#summon grenade at gun nozzle position
		Globals.grenade_amount -= 1;
		can_grenade = false
		$GrenadeTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		var player_direction = (get_global_mouse_position() - position).normalized()
		grenadeShot.emit(pos, player_direction)
		



func _on_laser_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true
