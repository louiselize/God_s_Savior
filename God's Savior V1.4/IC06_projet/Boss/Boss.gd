extends KinematicBody2D

onready var animationTree = $AnimationTree
onready var animationstate = animationTree.get("parameters/playback")
onready var velocity = Vector2.ZERO
onready var detection = $Detection
onready var sprite = $Sprite
onready var collisionshape = $CollisionShape2D
onready var stats = $Stats
onready var timer = $Timerarrows
onready var timer2 = $Timersalve
onready var timer3 = $Timerrafale
onready var timer4 = $Timerfinale

signal boss_dead


var FLECHE : PackedScene = preload("res://Boss/Flèche2.tscn")


func _ready():
	animationTree.active = true

	
enum {
	IDLE
	CHASE
	Attack
}

var state = CHASE

func _physics_process(delta):
	match state : 
		IDLE : 
			animationstate.travel("IDLE")
			velocity = velocity.move_toward(Vector2.ZERO,200*delta)
			_seek_player()
			
		CHASE : 
			var player = detection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction*20,300*delta)
				if direction.x<0 :
					sprite.flip_h
					collisionshape.position.x = -14 
				if timer.is_stopped() and timer2.is_stopped()==false and timer3.is_stopped()== false and timer4.is_stopped()==false:
					tir_fleche(player)
				
				if timer2.is_stopped() and timer3.is_stopped()==false and timer4.is_stopped()==false:
					salve(player)
				
				if timer3.is_stopped() and timer4.is_stopped()==false:
					rafale(player)
					
				if timer4.is_stopped():
					finale(player)
			else:
				state = IDLE
		
		
	velocity = move_and_slide(velocity)
		
func tir_fleche(player):
	var fleche = FLECHE.instance()
	get_tree().current_scene.add_child(fleche)
	fleche.global_position=self.global_position
	fleche.rotation = get_angle_to(player.global_position)+PI/2
	timer.start()
	

func salve(player):
	var fleche1 = FLECHE.instance()
	var fleche2 = FLECHE.instance()
	var fleche3 = FLECHE.instance()
	var fleche4 = FLECHE.instance()
	var fleche5 = FLECHE.instance()
	get_tree().current_scene.add_child(fleche1)
	get_tree().current_scene.add_child(fleche2)
	get_tree().current_scene.add_child(fleche3)
	get_tree().current_scene.add_child(fleche4)
	get_tree().current_scene.add_child(fleche5)
	fleche1.global_position=self.global_position
	fleche2.global_position=self.global_position
	fleche3.global_position=self.global_position
	fleche4.global_position=self.global_position
	fleche5.global_position=self.global_position
	fleche1.rotation = get_angle_to(player.global_position)+PI/2-PI/6
	fleche2.rotation = get_angle_to(player.global_position)+PI/2-PI/12
	fleche3.rotation = get_angle_to(player.global_position)+PI/2
	fleche4.rotation = get_angle_to(player.global_position)+PI/2+PI/12
	fleche5.rotation = get_angle_to(player.global_position)+PI/2+PI/6
	timer2.start()
	
	
func rafale(player):
	
	var angle = 0
	var count = 0
	while count != 48 :
		var fleche = FLECHE.instance()
		get_tree().current_scene.add_child(fleche)
		fleche.global_position=self.global_position
		fleche.rotation = angle
		angle += PI/12
		count+=1
	timer3.start()
	
func finale(player):
	var x = player.global_position.x-160
	var count = 0
	while count != 10 :
		var fleche = FLECHE.instance()
		get_tree().current_scene.add_child(fleche)
		fleche.global_position=Vector2(x,-80)
		fleche.rotation = PI
		x+= 32
		count+=1
	timer4.start()

func _seek_player():
	if detection.can_see_player():
		timer2.start()
		timer3.start()
		timer4.start()
		state = CHASE

func _on_Hurtbox_area_entered(area):
	print('aie')
	stats.health -=1  
	if(stats.health == 0):
		emit_signal("boss_dead")
	
func _on_Stats_no_health():
	var player = get_tree().current_scene.get_node("Player")
	print('boss death')
	emit_signal("boss_dead")
	queue_free()
	
