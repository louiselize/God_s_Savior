extends YSort

onready var music = $MusicMonde1

var stats = PlayerStats
var entree_state = "none"

func _ready():
	music.play()
	entree_state = stats.entree_state
	print(entree_state)
	if entree_state == "bas":
		get_node("CacheLayer/Cache").visible = true
		get_node("Entrée").play("Entrée_bas")
	elif entree_state =="mort":
		if stats.boss_state == "dead":
			get_node("CacheLayer/Cache").visible = true
			get_node("Entrée").play("Entrée_haut")
		else :
			get_node("CacheLayer/Cache").visible = true
			get_node("Entrée").play("Entrée_bas")
	elif entree_state =="haut":
		get_node("CacheLayer/Cache").visible = true
		get_node("Entrée").play("Entrée_haut")
	elif entree_state =="mort_boss":
		get_node("CacheLayer/Cache").visible = true
		get_node("Entrée").play("Entrée_haut")
	else :
		push_error("WRONG ENTREE_STATE")
		print(entree_state)
		
