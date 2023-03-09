extends Area2D

onready var speed = 100



func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation-PI/2)
	global_position+=direction*speed*delta

func destroy():
	queue_free()



func _on_Area2D_area_entered(area):
	destroy()


func _on_Area2D_body_entered(body):
	destroy()


func _on_VisibilityNotifier2D_screen_exited():
	destroy()
