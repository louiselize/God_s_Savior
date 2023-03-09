extends Area2D

func _input(event):
	if event.is_action_pressed("ui_action") and len(get_overlapping_bodies()) > 0:
		get_parent().get_parent().get_node("intro_trans").play("intro_trans")
