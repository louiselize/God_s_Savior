extends AnimationPlayer

func find_and_use_dialogue(N_intro,CHAR, N_dlg):
	if CHAR =="Chef":
		var dialogue_player = get_node_or_null("DialogueIntro_Chef")
		if dialogue_player:
			self.stop(false)
			dialogue_player.play(N_intro, N_dlg)
	
	elif CHAR =="Demetrius":
		var dialogue_player = get_node_or_null("DialogueIntro_Demetrius")
		if dialogue_player:
			self.stop(false)
			dialogue_player.play(N_intro, N_dlg)
	else:
		var dialogue_player = get_node_or_null("DialogueIntro_Game")
		if dialogue_player:
			self.stop(false)
			dialogue_player.play(N_intro, N_dlg)
