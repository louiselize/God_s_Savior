extends AnimationPlayer

var stats = PlayerStats

func _on_the_end_epiloge_animation_finished(anim_name):
	stats.entree_state = "intro"
	stats.health = stats.max_health
	get_tree().change_scene("res://Screens/TitleScreen.tscn")

func find_and_use_dialogue(N_intro,CHAR, N_dlg):
	if CHAR =="D":
		var dialogue_player = get_node_or_null("Dialoguesoutro_Game_D")
		if dialogue_player:
			self.stop(false)
			dialogue_player.play(N_intro, N_dlg)

	else:
		var dialogue_player = get_node_or_null("Dialoguesoutro_Game_G")
		if dialogue_player:
			self.stop(false)
			dialogue_player.play(N_intro, N_dlg)
