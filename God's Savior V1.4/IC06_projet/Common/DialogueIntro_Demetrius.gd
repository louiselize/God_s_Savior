extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_id = 0
var is_dialogue_active = false
var count = 0
var N_dlg=0
var N_intro=0

func _ready():
	$NinePatchRect.visible=false

func get_count():
	count = str(dialogues["intro1"][0]["count"])
	count=int(count)
	print(count)

func play(i, j):
	N_intro = i
	N_dlg = j
	print(N_intro, N_dlg)
	if is_dialogue_active:
		return
	dialogues = load_dialogues()
	turn_off_the_player()
	get_count()
	print(count)
	is_dialogue_active=true
	push_warning("true")
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
	print(dialogues["intro"+str(N_intro)][0]["Demetrius"+str(N_dlg)])
	if current_dialogue_id >= len(dialogues["intro"+str(N_intro)][0]["Demetrius"+str(N_dlg)]):
		$Timer_D.start()
		$NinePatchRect.visible=false
		push_error("FALSE")
		turn_on_the_player()
		return
	$NinePatchRect/Name.text= "Demetrius"
	$NinePatchRect/Message.text=dialogues["intro"+str(N_intro)][0]["Demetrius"+str(N_dlg)][current_dialogue_id]

func load_dialogues():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file,file.READ)
		return parse_json(file.get_as_text())

func _on_Timer_D_timeout():
	push_warning("TIMER")
	is_dialogue_active = false
	get_parent().play()

func turn_on_the_player():
	var player = get_tree().get_root().find_node("Player",true, false)
	if player:
		player.set_active(true)

func turn_off_the_player():
	var player = get_tree().get_root().find_node("Player",true, false)
	if player:
		player.set_active(false)

