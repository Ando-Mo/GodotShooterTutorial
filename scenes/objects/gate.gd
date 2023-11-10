extends StaticBody2D

signal player_entered_gate

func _on_area_2d_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($"../Player","speed",0,0.5) 
	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
