extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 90
const FRICTION = 500

enum {
	MOVE,
	ATTACK,
	TIR,
}

var att_enable = true
var current_scene
var tir_enable = false

var state = MOVE
var velocity = Vector2.ZERO 
var stats = PlayerStats

var input_vector = Vector2.ZERO
var direction = Vector2.ZERO
# VECTOR is made of (X, Y  and is REPRESENTING OUR POSITION

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var sprite = $Sprite
onready var deathSound = $Death
onready var hurtSound = $Hurt
onready var timer = $Cooldown

onready var animationState = animationTree.get("parameters/playback")
var FLECHE : PackedScene = preload("res://Player/FlècheP.tscn")


func _ready():
	stats.connect("no_health",self,"player_death")
	animationTree.active = true
	if stats.boss_state == "dead":
		tir_enable = true
	else :
		tir_enable = false

	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		TIR:
			tir_state(delta)
		

func set_active(active):
	if active == true :
		get_node("AnimationPlayer").stop()
		set_physics_process(active)
		set_process(active)
		set_process_input(active)
	else :
		animationState.travel("Idle")
		animationTree.set("parameters/Idle/blend_position",Vector2(0,-1))
		"""get_node("AnimationPlayer").play("IdleUp")"""
		set_physics_process(active)
		set_process(active)
		set_process_input(active)

func set_active_diag(active):
		set_physics_process(active)
		set_process(active)
		set_process_input(active)
		
func move_state(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")		
	input_vector = input_vector.normalized()
	if input_vector.x != 0 or input_vector.y !=0 :
		direction=input_vector

	
	if(input_vector != Vector2.ZERO):
		animationTree.set("parameters/Idle/blend_position",input_vector)
		animationTree.set("parameters/Run/blend_position",input_vector)			
		animationTree.set("parameters/Attack/blend_position",input_vector)
		animationTree.set("parameters/Arc/blend_position",input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)	
		
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack_action"):
		if att_enable==true:
			state = ATTACK
		else:
			pass
			
	_input(InputEventKey)
		
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_A and tir_enable:
			print("input event player")
			state = TIR
		else: 
			pass
			
func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")


func attack_animation_finished():
	state = MOVE

func Arc_animation_finished():
	state = MOVE

func tir_state(delta):
	velocity = Vector2.ZERO
	if timer.is_stopped():
		animationState.travel("Arc")
		var fleche = FLECHE.instance()	
		get_tree().current_scene.add_child(fleche)
		fleche.global_position=self.global_position
		fleche.rotation = direction.angle() +PI/2
		timer.start()


func _on_Hurtbox_area_entered(area):
	hurtSound.play()
	stats.health -= 1
	yield(get_tree().create_timer(0.5), "timeout")
	hurtSound.stop()
	
func player_death():
	stats.entree_state = "mort"
	deathSound.play()
	stats.current_scene = get_tree().get_current_scene().get_name()
	stats.current_scene_path = get_tree().current_scene.filename
	get_tree().change_scene("res://Common/DeathScreen.tscn")

	
	for i in range(4):
		self.set_visible(false)
		yield(get_tree().create_timer(0.25), "timeout")
		self.set_visible(true)
		yield(get_tree().create_timer(0.5), "timeout")
	deathSound.stop()

func set_att_var(state):
	att_enable=true
	
func tir_enable(state):
	print("enable tir")
	tir_enable=true
	
