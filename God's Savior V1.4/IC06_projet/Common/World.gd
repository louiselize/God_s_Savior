extends YSort

onready var music = $MusicVillage

var stats = PlayerStats
var entree_state = "village"

func _ready():
	music.play()
	entree_state = stats.entree_state
	"""stats.boss_state ="dead"
	entree_state ="fin" """
	if entree_state == "village":
		get_node("Portes_intro").queue_free()
		if stats.boss_state =="alive":
			get_node("CacheLayer/Cache").visible = true
			get_node("Entrée_Sortie").play("Entrée_village")
		else:
			get_node("YSort/Demetrius/Area2D/CollisionShape2D").disabled = true
			get_node("travelling/Suite_intro_detect/CollisionShape2D").disabled = false
			get_node("CacheLayer/Cache").visible = true
			get_node("Portes_intro/CollisionShape2D").disabled = true
			get_node("Portes_intro/CollisionShape2D2").disabled = true
			get_node("fin_intro").play("intro_fin")

	elif entree_state == "intro":
		get_node("CacheLayer/Cache").visible = false
		get_node("YSort/Demetrius/Area2D/CollisionShape2D").disabled = true
		get_node("travelling/Suite_intro_detect/CollisionShape2D").disabled = false
		get_node("travelling").play("travelling")
	elif entree_state=="mort":
		get_node("CacheLayer/Cache").visible = true
		get_node("YSort/Demetrius/Area2D/CollisionShape2D").disabled = false
		get_node("travelling/Suite_intro_detect/CollisionShape2D").disabled = true
		get_node("Entrée_Sortie").play("Entrée_village_mort")
		get_node("Portes_intro").queue_free()

	else :
		pass
		

	"""elif entree_state =="fin":
		get_node("Portes_intro").queue_free()
		get_node("YSort/Demetrius/Area2D/CollisionShape2D").disabled = true
		get_node("travelling/Suite_intro_detect/CollisionShape2D").disabled = false
		get_node("CacheLayer/Cache").visible = true
		get_node("Entrée_Sortie").play("Entrée_village") """
