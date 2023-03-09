extends KinematicBody2D

onready var stats = $Stats

onready var acc = 300
onready var maxspeed = 50
onready var velocity = Vector2.ZERO
onready var detection = $Detection
onready var sprite = $Sprite
onready var hurtSound = $Hurt
onready var timer = $Cooldown

var BDF : PackedScene = preload("res://Ennemi/BDF.tscn")

enum {
	IDLE
	CHASE
}

var state = CHASE
var isDying = false

func _physics_process(delta):
	match state : 
		IDLE : 
			velocity = velocity.move_toward(Vector2.ZERO,200*delta)
			_seek_player()
			
		CHASE : 
			var player = detection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				if self.global_position.distance_to(player.global_position)>=70:
					velocity = velocity.move_toward(direction*maxspeed,acc*delta)
				else:
					velocity=velocity.move_toward(Vector2.ZERO,200*delta)
					if timer.is_stopped():
						tir_BDF(player)
					
			else:
				state = IDLE
				
			sprite.flip_h = velocity.x>0
	velocity = move_and_slide(velocity)
		

func tir_BDF(player):
	var bdf = BDF.instance()
	get_tree().current_scene.add_child(bdf)
	bdf.global_position=self.global_position
	bdf.rotation = get_angle_to(player.global_position)+PI/2
	timer.start()

func _seek_player():
	if detection.can_see_player():
		state = CHASE


func _on_Hurtbox_area_entered(area):
	stats.health -= 1

	


func _on_Stats_no_health():
	#hurtSound.play()
	isDying = true
	#for i in range(2):
	#	self.set_visible(true)
	#	yield(get_tree().create_timer(0.05), "timeout")
	#	self.set_visible(false)
	#	yield(get_tree().create_timer(0.1), "timeout")
	#hurtSound.stop()
	queue_free()
