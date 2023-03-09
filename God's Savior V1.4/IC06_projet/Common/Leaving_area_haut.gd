extends Area2D

var stats = PlayerStats

func _input(event):
	if len(get_overlapping_bodies()) > 0:
		get_parent().get_node("Sortie").play("Sortie_Haut")

func _on_Sortie_animation_finished(anim_name):
	if anim_name == "Sortie_Haut":
		stats.inc +=1
		stats.entree_state = "boss" + str(stats.inc)
		get_tree().change_scene("res://Common/BossRoom.tscn")
	else:
		pass
