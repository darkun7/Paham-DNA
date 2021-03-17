extends Node2D

onready var global = get_node("/root/global")

var ra3 = preload("res://asset/dna/Purple-Orange-1-Rotate.png")
var ra2 = preload("res://asset/dna/Purple-Orange-2-Rotate.png")
var ra1 = preload("res://asset/dna/Purple-Orange-3-Rotate.png")
var rt3 = preload("res://asset/dna/Purple-Blue-1-Rotate.png")
var rt2 = preload("res://asset/dna/Purple-Blue-2-Rotate.png")
var rt1 = preload("res://asset/dna/Purple-Blue-3-Rotate.png")
var rg3 = preload("res://asset/dna/Purple-Green-1-Rotate.png")
var rg2 = preload("res://asset/dna/Purple-Green-2-Rotate.png")
var rg1 = preload("res://asset/dna/Purple-Green-3-Rotate.png")
var rc3 = preload("res://asset/dna/Purple-Pink-1-Rotate.png")
var rc2 = preload("res://asset/dna/Purple-Pink-2-Rotate.png")
var rc1 = preload("res://asset/dna/Purple-Pink-3-Rotate.png")

var la3 = preload("res://asset/dna/Red-Orange-1.png")
var la2 = preload("res://asset/dna/Red-Orange-2.png")
var la1 = preload("res://asset/dna/Red-Orange-3.png")
var lt3 = preload("res://asset/dna/Red-Blue-1.png")
var lt2 = preload("res://asset/dna/Red-Blue-2.png")
var lt1 = preload("res://asset/dna/Red-Blue-3.png")
var lg3 = preload("res://asset/dna/Red-Green-1.png")
var lg2 = preload("res://asset/dna/Red-Green-2.png")
var lg1 = preload("res://asset/dna/Red-Green-3.png")
var lc3 = preload("res://asset/dna/Red-Pink-1.png")
var lc2 = preload("res://asset/dna/Red-Pink-2.png")
var lc1 = preload("res://asset/dna/Red-Pink-3.png")

var mark = preload("res://asset/dna/marker.png")

#onready var dna = get_node(dna).instance()
var speed = 1.5
var id = 0
var ids = 1
var dna = load("res://scene/dna.tscn")
var size = 1
var sizeAr= [1,2,3,2]
var score = 0
var nucleotide = 46
var pause_state = false
var next_scene = "res://scene/";

var benar = 0
var salah = 0
var kalah = 1

var lang = "EN"

func _ready():
	print("Successfully enter scene Game")
	$spawn.wait_time = speed
	speed = global.get_global_speed()
	nucleotide = global.get_global_nucleotide()
	var kesulitan = global.get_global_kesulitan()
	print(kesulitan)
	
	if(kesulitan == "Mudah"):
		$latar/difficulty.set("custom_colors/font_color",Color(0,123,255))
	elif(kesulitan == "Sedang"):
		$latar/difficulty.set("custom_colors/font_color",Color(0,255,0))
	elif(kesulitan == "Sulit"):
		$latar/difficulty.set("custom_colors/font_color",Color(255,155,0))
	elif(kesulitan == "Tak Hingga"):
		$latar/difficulty.set("custom_colors/font_color",Color(255,0,0))
		$latar/percent.visible = false
	if(lang == "EN"):
		kesulitan = translate(kesulitan)
		$pause/Keluar/Label.text = "Exit"
		
	$latar/difficulty.text = str(kesulitan)
	$fade.doOut()

func translate(string):
	var translate = {
		'Mudah': "Easy",
		'Sedang': "Medium",
		'Sulit': "Hard",
		'Tak Hingga' : "infinity",
		'komentar_cobalagi' : "Nucleotide A pairs with T, while G pairs with C",
	}
	return translate[string]

func spawn():
	id+=1
	size+=1
	if size>=4:
		size=0
	
	var object = dna.instance()
	object.name = "dna_"+str(id)
	var gene = random_gene()
	object.set_gene(gene)
	object.set_size(sizeAr[size])
	dna_texture(object)
	object.set_speed(speed*100)
	object.set_position($spawnpos.get_position()) 
	$spawnpos.add_child(object)
	#update_marker()
	
	#print(str(sizeAr[size])+str(object.get_gene()))

func _on_Spawn_timeout():
	if $spawnpos.get_child_count()<nucleotide:
		spawn()

func random_gene()->String:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random = rng.randi_range(1, 4)
	var gene
	if(random==1):
		gene = "A"
	elif(random==2):
		gene = "T"
	elif(random==3):
		gene = "G"
	else:
		gene = "C"
	return gene

func dna_texture(object):
	var num = object.get_size()
	if(object.get_gene()=="A"):
		if(num==1 || num==0):
			object.get_node("right").set_texture(ra1)
		elif(num==2):
			object.get_node("right").set_texture(ra2)
		elif(num==3):
			object.get_node("right").set_texture(ra3)
	elif(object.get_gene()=="T"):
		if(num==1 || num==0):
			object.get_node("right").set_texture(rt1)
		elif(num==2):
			object.get_node("right").set_texture(rt2)
		elif(num==3):
			object.get_node("right").set_texture(rt3)
	elif(object.get_gene()=="G"):
		if(num==1 || num==0):
			object.get_node("right").set_texture(rg1)
		elif(num==2):
			object.get_node("right").set_texture(rg2)
		elif(num==3):
			object.get_node("right").set_texture(rg3)
	elif(object.get_gene()=="C"):
		if(num==1 || num==0):
			object.get_node("right").set_texture(rc1)
		elif(num==2):
			object.get_node("right").set_texture(rc2)
		elif(num==3):
			object.get_node("right").set_texture(rc3)
	pass
	
func dna_texture_ans(object):
	var num = object.get_size()
	if(object.get_gene_ans()=="A"):
		if(num==1 || num==0):
			object.get_node("left").set_texture(la1)
		elif(num==2):
			object.get_node("left").set_texture(la2)
		elif(num==3):
			object.get_node("left").set_texture(la3)
	elif(object.get_gene_ans()=="T"):
		if(num==1 || num==0):
			object.get_node("left").set_texture(lt1)
		elif(num==2):
			object.get_node("left").set_texture(lt2)
		elif(num==3):
			object.get_node("left").set_texture(lt3)
	elif(object.get_gene_ans()=="G"):
		if(num==1 || num==0):
			object.get_node("left").set_texture(lg1)
		elif(num==2):
			object.get_node("left").set_texture(lg2)
		elif(num==3):
			object.get_node("left").set_texture(lg3)
	elif(object.get_gene_ans()=="C"):
		if(num==1 || num==0):
			object.get_node("left").set_texture(lc1)
		elif(num==2):
			object.get_node("left").set_texture(lc2)
		elif(num==3):
			object.get_node("left").set_texture(lc3)
	#object.get_node("right").texture="res://asset/dna/Purple-Blue-1-Rotate.png"
	pass
	
func update_marker():
	var check=ids-1
	var target = $spawnpos.find_node("dna_"+str(ids-1),true,false)
	if(target!=null):
		target.get_node("marker").set_texture(mark)
	pass

func action(gene):
	var target = $spawnpos.find_node("dna_"+str(ids),true,false)
	if(target!=null):
		target.set_gene_ans(gene)
		target.get_node("marker").texture = null
		target.set_fill(true)
		#print(str(target.get_fill()))
		dna_texture_ans(target)
		
		checkNilai(target)
		ids+=1
	pass

func checkNilai(target):
	var soal = target.get_gene()
	var jawab = target.get_gene_ans()
	if (soal=="A" and jawab=="T")||(soal=="T" and jawab=="A")||(soal=="G" and jawab=="C")||(soal=="C" and jawab=="G"):
		score+=100
		benar+=1
		$background.get_node("actionRespond").play("correct")
	else:
		salah+=1
		$background.get_node("actionRespond").play("wrong")
		hasil("Coba Lagi", [soal,jawab])
	var percent = (score/nucleotide)
	$latar.get_node("score").text = "Score: "+str(score)
	$latar.get_node("percent").text = str(percent)+"%"

func _on_A_pressed():
	action("A")

func _on_T_pressed():
	action("T")

func _on_G_pressed():
	action("G")

func _on_C_pressed():
	action("C")

func _on_Setting_pressed():
	if(!pause_state):
		get_tree().paused = true
		$pause.visible = true
	else:
		get_tree().paused = false
		$pause.visible = false
	pause_state = !pause_state
	if lang == "EN":
		$pause/title.text = "Setting"

func _on_Tutorial_pressed():
	$pause.visible = false
	$tutorial.visible = true

func _on_Keluar_pressed():
	next_scene += 'home.tscn'
	$fade.doIn()
	get_tree().paused = false
	pause_state = !pause_state

func _on_hasil_close_pressed():
	next_scene += 'home.tscn'
	$fade.doIn()
	get_tree().paused = false
	pause_state = !pause_state

func _on_fade_animation_finished(anim_name):
	if(next_scene!="res://scene/"):
		get_tree().change_scene(next_scene)

func _on_setting_close_pressed():
	get_tree().paused = false
	pause_state = !pause_state
	$pause.visible = false
	

func _on_tutorial_close_pressed():
	get_tree().paused = false
	pause_state = !pause_state
	$tutorial.visible = false


func _on_criticalArea_body_entered(body):
	if !(body.get_fill()):
		kalah-=1
		if(kalah<0):
			hasil("Coba Lagi", [""])
	if body.name== "dna_"+str(nucleotide):
		hasil("Berhasil", [""])
		
func hasil(jenis:String, komentar):
	get_tree().paused = true
	pause_state = true
	if(jenis=="Berhasil"):
		$hasil.visible= true
		$hasil/title.text = "Berhasil"
		$hasil/title.set("custom_colors/font_color",Color(0,255,0))
		$hasil/label.text = "Persentase: "+str(score/nucleotide)+"%\nScore: "+str(score)+"\nJawaban benar: "+str(benar)+"\nJawaban salah: "+str(salah)
		$hasil/TextureRect.visible = false;
	elif(jenis=="Coba Lagi"):
		$hasil.visible= true
		$hasil/title.text = "Coba Lagi"
		$hasil/title.set("custom_colors/font_color",Color(255,0,0))
		$hasil/label.text = "Nukleotida A berpasangan dengan T, sedangkan G berpasangan dengan C"
		$hasil/label.text = translate('komentar_cobalagi')
		if(komentar[0] !=""):
			var nucleo = "Nukleotida "
			var respond = " seharusnya berpasangan dengan "
			var not_with = ", bukan dengan "
			if (lang == "EN"):
				respond = " should paired with  "
				nucleo = "Nucleotide "
				not_with = ", not a "
			var soal = komentar[0]
			var jawab = komentar[1]
			if soal == "A":
				respond = nucleo+soal+respond+"T"+not_with+jawab
			elif soal == "T":
				respond = nucleo+soal+respond+"A"+not_with+jawab
			elif soal == "G":
				respond = nucleo+soal+respond+"C"+not_with+jawab
			elif soal == "C":
				respond = nucleo+soal+respond+"G"+not_with+jawab
			$hasil/label.text = respond
		$hasil/TextureRect.visible = true;
	else:
		pass
	pass

func _on_tutorial_close_btn():
	get_tree().paused = false
	pause_state = !pause_state
	$tutorial.visible = false
