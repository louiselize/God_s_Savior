extends AnimationPlayer

func find_and_use_dialogue(N_intro,CHAR, N_dlg):
	if CHAR =="Artemis":
		var dialogue_player = get_node_or_null("Dialogue_Artemis")
		if dialogue_player:
			self.stop(false)
			dialogue_player.play(N_intro, N_dlg)
	
	elif CHAR =="Neant":
		var dialogue_player = get_node_or_null("Dialogue_Neant")
		if dialogue_player:
			self.stop(false)
			dialogue_player.play(N_intro, N_dlg)
	else:
		var dialogue_player = get_node_or_null("Dialogue_Game")
		if dialogue_player:
			self.stop(false)
			dialogue_player.play(N_intro, N_dlg)


func _on_Entre_Sortie_animation_finished(anim_name):
	if anim_name == "Entrée":
		self.play("intro_artemis")
	else:
		pass
