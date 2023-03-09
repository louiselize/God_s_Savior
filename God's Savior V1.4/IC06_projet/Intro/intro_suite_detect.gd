extends AnimationPlayer

var stats = PlayerStats

func _on_intro_trans_animation_finished(anim_name):
	if stats.boss_state == "alive":
		get_parent().get_node("intro_suite").play("intro_suite")
	else :
		get_parent().get_node("the end").play("the_end")
