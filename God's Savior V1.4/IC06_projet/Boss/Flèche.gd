extends KinematicBody2D

onready var distance = 0
onready var vitesse = 500
onready var launch = false

func _ready():
	pass 

func _process(delta):
	if launch :
		position = vitesse*delta
		rotation = vitesse.angle()
		vitesse = move_and_slide(vitesse)
