extends Area2D

var stats = PlayerStats


func _input(event):
	if len(get_overlapping_bodies()) > 0:
		if stats.boss_state == "alive":
			pass
		else :
		 get_parent().get_node("Entrée_Sortie").play("Sortie")
	
func _on_Entre_Sortie_animation_finished(anim_name):
	if anim_name=="Sortie" :
		stats.entree_state="haut"
		get_tree().change_scene("res://Common/Monde1.tscn")
	else : 
		pass
