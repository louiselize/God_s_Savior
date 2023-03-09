extends Control

func _ready():
	$Press_E.visible = false
	$Timer.start()

func _on_Timer_timeout():
	$Press_E.visible = not $Press_E.visible
	$Timer.start()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	if event.is_action_pressed("ui_action"):
		get_tree().change_scene("res://Common/World.tscn")
		get_tree().paused = false
