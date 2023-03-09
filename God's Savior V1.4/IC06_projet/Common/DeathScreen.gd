extends Control

var stats = PlayerStats

func _ready():
	$Press_E.visible = false
	$Timer.start()

func _on_Timer_timeout():
	$Press_E.visible = not $Press_E.visible
	$Timer.start()
	
func _input(event):
	if event.is_action_pressed("ui_action"):
		print(stats.current_scene_path)
		if stats.current_scene == "BossRoom":
			stats.inc -=1
			stats.entree_state = "mort_boss"
			stats.health = stats.max_health
			get_tree().change_scene("res://Common/Monde1.tscn")
		else :
			stats.health = stats.max_health
			get_tree().change_scene(stats.current_scene_path)
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
