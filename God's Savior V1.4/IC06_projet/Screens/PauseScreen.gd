extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("Color_bdg")

func _ready():
	$Color_bdg.visible=false


var paused: = false setget set_paused

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_pause"):
		self.paused = not paused
	if $Color_bdg.visible :
		if event.is_action_pressed("ui_cancel"):
			get_tree().quit()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
