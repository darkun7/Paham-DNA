extends Node

onready var global = get_node("/root/global")
var next_scene = "res://scene/";


func _ready():
	pass

func _on_Game_pressed():
	$kesulitan.visible = true

func _on_Materi_pressed():
	print("entering materi scene")
	next_scene += 'materi.tscn'
	$fade.doIn()

func _on_About_pressed():
	print("entering about scene")
	$tentang.visible = true

func _on_close_pressed():
	$tentang.visible = false

func _on_Tutorial_pressed():
	$tutorial.visible = true

func _on_fade_fade_finished():
	get_tree().change_scene(next_scene)

func _on_tutorial_close_btn():
	$tutorial.visible = false

func masukGame():
	print("entering game scene")
	next_scene += 'game_dna.tscn'
	$fade.doIn()

func _on_kesulitan_close_pressed():
	$kesulitan.visible = false

func _on_level_mudah_pressed():
	global.set_global_speed(1.5)
	global.set_global_nucleotide(46)
	global.set_global_kesulitan("Mudah")
	masukGame()

func _on_level_sedang_pressed():
	global.set_global_speed(1.5)
	global.set_global_nucleotide(92)
	global.set_global_kesulitan("Sedang")
	masukGame()

func _on_level_sulit_pressed():
	global.set_global_speed(2)
	global.set_global_nucleotide(96)
	global.set_global_kesulitan("Sulit")
	masukGame()

func _on_level_tak_hingga_pressed():
	global.set_global_speed(1.5)
	global.set_global_nucleotide(99999)
	global.set_global_kesulitan("Tak Hingga")
	masukGame()



