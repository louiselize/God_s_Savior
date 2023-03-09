extends Area2D

var stats = PlayerStats

func _input(event):
	if len(get_overlapping_bodies()) > 0:
		get_tree().change_scene("res://Monde1.tscn")
