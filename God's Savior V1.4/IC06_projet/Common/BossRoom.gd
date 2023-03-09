extends YSort

onready var music = $MusicBoss

var stats = PlayerStats
var entree_state = "none"

func _ready():
	music.play()
	entree_state = stats.entree_state
	print(entree_state)
	if entree_state == "boss1":
		get_node("Artemis").visible = true
		get_node("Boss").visible = false
		get_node("CacheLayer/Cache").visible = true
		get_node("Entrée_Sortie").play("Entrée")
	else :
		get_node("Boss").queue_free()
		get_node("Artemis").queue_free()
		get_node("Player/Player_cam").current = true

func _on_Boss_boss_dead():
	stats.boss_state = "dead"
	get_node("artemis").play("outro_artemis")
