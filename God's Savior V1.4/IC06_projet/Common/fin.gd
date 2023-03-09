extends AnimationPlayer

var stats = PlayerStats

func remove_ennemis(number):
	get_parent().get_node("YSort/Ennemi"+str(number)).queue_free()

func remove_all_ennemis():
	for i in range (3,5):
		get_parent().get_node("YSort/Ennemi"+str(i)).queue_free()
	

func _on_fin_animation_finished(anim_name):
	stats.entree_state = "fin"
	remove_all_ennemis()
	get_parent().get_node("Entrée_Sortie").play("Entrée_village")
