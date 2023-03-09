extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_id = 0
var is_dialogue_active = false
var txt_length = 0
var id_json ="none"
var stats = PlayerStats

func _ready():
	$NinePatchRect.visible=false


func play():
	if is_dialogue_active:
		return
	dialogues = load_dialogues()
	turn_off_the_player()
	is_dialogue_active=true
	$NinePatchRect.visible=true 
	current_dialogue_id = -1 
	next_line()

func _input(event):
	if not is_dialogue_active:
		return
	if event.is_action_pressed("ui_action"):
		next_line()

func next_line():
	current_dialogue_id +=1
	if stats.boss_state == "alive" :
		id_json = "intro_village"
	else : 
		id_json = "intro_outro_village"
	
	if current_dialogue_id >= len(dialogues[id_json][0][get_parent().get_parent().get_name()]):
		$Timer.start()
		$NinePatchRect.visible=false
		turn_on_the_player()
		return
	$NinePatchRect/Name.text= get_parent().get_parent().get_name()
	$NinePatchRect/Message.text=dialogues[id_json][0][get_parent().get_parent().get_name()][current_dialogue_id]
	$NinePatchRect/Message.percent_visible = 0
	txt_length = str(dialogues[id_json][0][get_parent().get_parent().get_name()][current_dialogue_id]).length()
	$Tween.interpolate_property($NinePatchRect/Message,"percent_visible",0,1,txt_length,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.set_speed_scale(40)
	$Tween.start()

func load_dialogues():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file,file.READ)
		return parse_json(file.get_as_text())

func _on_Timer_timeout():
	is_dialogue_active=false

func turn_on_the_player():
	var player = get_tree().get_root().find_node("Player",true, false)
	if player:
		player.set_active_diag(true)

func turn_off_the_player():
	var player = get_tree().get_root().find_node("Player",true, false)
	if player:
		player.set_active_diag(false)
