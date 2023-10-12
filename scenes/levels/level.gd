extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")


func _on_player_laser_shot(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction 
	#add laser instance to an existing Node2D
	$Projectiles.add_child(laser)


func _on_player_grenade_shot(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)


func _on_house_player_entered(): 
	var tween = get_tree().create_tween()
	tween.set_parallel(true) ##allows tweens to play at the same times
	tween.tween_property($Player/Camera2D, "modulate:a", 0, 2).from(0.5)
	##from creates the start value of the tween
	#modulate:a is shortcut for modulating Alpha channel 
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1 ).set_trans(Tween.TRANS_QUAD)
	##set_trans allows you to specify the transition of the tween


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
