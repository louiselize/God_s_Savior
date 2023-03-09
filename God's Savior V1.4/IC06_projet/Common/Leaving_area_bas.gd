extends Area2D

var stats = PlayerStats

func _input(event):
	if len(get_overlapping_bodies()) > 0:
		get_parent().get_node("Sortie").play("Sortie_Bas")

func _on_Sortie_animation_finished(anim_name):
	if anim_name == "Sortie_Bas":
		stats.entree_state = "village"
		get_tree().change_scene("res://Common/World.tscn")
	else :
		pass
