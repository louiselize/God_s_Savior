extends Area2D

var stats = PlayerStats

func _input(event):
	if len(get_overlapping_bodies()) > 0:
		stats.entree_state = "bas"
		get_parent().get_node("Entrée_Sortie").play("Sortie_village")

func _on_Entre_Sortie_animation_finished(anim_name):
	if anim_name == "Sortie_village":
		get_tree().change_scene("res://Common/Monde1.tscn")
	else:
		pass
