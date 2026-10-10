
extends Node2D

@onready var global = get_node("/root/global")

# DNA textures
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

const DNA_SCENE = preload("res://scene/dna.tscn")
const HOME_SCENE = "res://scene/home.tscn"

var speed: float = 1.5
var id: int = 0
var ids: int = 1
var size: int = 1
var sizeAr = [1, 2, 3, 2]

var score: int = 0
var nucleotide: int = 46
var pause_state: bool = false
var next_scene: String = ""

var benar: int = 0
var salah: int = 0
var kalah: int = 1

var lang: String = "EN"
var game_finished: bool = false
var transitioning: bool = false


func _ready() -> void:
	print("Successfully enter scene Game")

	speed = float(global.get_global_speed())
	nucleotide = int(global.get_global_nucleotide())

	# Prevent invalid timer duration.
	speed = maxf(speed, 0.01)
	nucleotide = maxi(nucleotide, 1)

	$spawn.wait_time = speed

	var kesulitan: String = str(global.get_global_kesulitan())
	print(kesulitan)

	match kesulitan:
		"Mudah":
			$latar/difficulty.add_theme_color_override(
				"font_color", Color8(0, 123, 255)
			)
		"Sedang":
			$latar/difficulty.add_theme_color_override(
				"font_color", Color8(0, 255, 0)
			)
		"Sulit":
			$latar/difficulty.add_theme_color_override(
				"font_color", Color8(255, 155, 0)
			)
		"Tak Hingga":
			$latar/difficulty.add_theme_color_override(
				"font_color", Color8(255, 0, 0)
			)
			$latar/percent.visible = false

	if lang == "EN":
		kesulitan = translate_text(kesulitan)
		$pause/Keluar/Label.text = "Exit"

	$latar/difficulty.text = kesulitan
	$fade.doOut()


# Renamed to avoid collision with Node2D.translate()
func translate_text(key: String) -> String:
	var translations = {
		"Mudah": "Easy",
		"Sedang": "Medium",
		"Sulit": "Hard",
		"Tak Hingga": "Infinity",
		"komentar_cobalagi": "Nucleotide A pairs with T, while G pairs with C"
	}

	return str(translations.get(key, key))


func spawn() -> void:
	if game_finished:
		return

	id += 1
	size += 1

	if size >= 4:
		size = 0

	var object = DNA_SCENE.instantiate()

	if object == null:
		push_error("Failed to instantiate DNA scene.")
		return

	object.name = "dna_" + str(id)

	var gene = random_gene()

	object.set_gene(gene)
	object.set_size(sizeAr[size])

	dna_texture(object)

	#object.set_velocity(speed * 100.0)
	object.set_move_speed(speed * 100.0)
	#object.set_velocity(Vector2(0.0, speed * 100.0))
	object.position = $spawnpos.position

	$spawnpos.add_child(object)


func _on_Spawn_timeout() -> void:
	if game_finished:
		return

	if $spawnpos.get_child_count() < nucleotide:
		spawn()


func random_gene() -> String:
	var genes = ["A", "T", "G", "C"]
	return genes[randi_range(0, genes.size() - 1)]


func dna_texture(object) -> void:
	var num: int = int(object.get_size())
	var gene: String = str(object.get_gene())

	var textures = {
		"A": [ra1, ra2, ra3],
		"T": [rt1, rt2, rt3],
		"G": [rg1, rg2, rg3],
		"C": [rc1, rc2, rc3]
	}

	if not textures.has(gene):
		return

	var index = clampi(num - 1, 0, 2)
	var sprite = object.get_node_or_null("right")

	if sprite != null:
		sprite.texture = textures[gene][index]


func dna_texture_ans(object) -> void:
	var num: int = int(object.get_size())
	var gene: String = str(object.get_gene_ans())

	var textures = {
		"A": [la1, la2, la3],
		"T": [lt1, lt2, lt3],
		"G": [lg1, lg2, lg3],
		"C": [lc1, lc2, lc3]
	}

	if not textures.has(gene):
		return

	var index = clampi(num - 1, 0, 2)
	var sprite = object.get_node_or_null("left")

	if sprite != null:
		sprite.texture = textures[gene][index]


func update_marker() -> void:
	var target = $spawnpos.find_child(
		"dna_" + str(ids - 1), true, false
	)

	if target != null:
		var marker_node = target.get_node_or_null("marker")

		if marker_node != null:
			marker_node.texture = mark


func action(gene: String) -> void:
	if game_finished or pause_state:
		return

	var target = $spawnpos.find_child(
		"dna_" + str(ids), true, false
	)

	if target == null:
		return

	target.set_gene_ans(gene)

	var marker_node = target.get_node_or_null("marker")

	if marker_node != null:
		marker_node.texture = null

	target.set_fill(true)

	dna_texture_ans(target)
	checkNilai(target)

	ids += 1


func checkNilai(target) -> void:
	var soal: String = str(target.get_gene())
	var jawab: String = str(target.get_gene_ans())

	var pasangan = {
		"A": "T",
		"T": "A",
		"G": "C",
		"C": "G"
	}

	if pasangan.get(soal, "") == jawab:
		score += 100
		benar += 1
		$background/actionRespond.play("correct")
	else:
		salah += 1
		$background/actionRespond.play("wrong")
		hasil("Coba Lagi", [soal, jawab])

	var percent: float = (
		float(score) / float(nucleotide)
	)

	$latar/score.text = "Score: " + str(score)
	$latar/percent.text = "%.2f%%" % percent


# DNA answer buttons

func _on_A_pressed() -> void:
	action("A")


func _on_T_pressed() -> void:
	action("T")


func _on_G_pressed() -> void:
	action("G")


func _on_C_pressed() -> void:
	action("C")


# Pause management

func set_game_paused(value: bool) -> void:
	pause_state = value
	get_tree().paused = value


func _on_Setting_pressed() -> void:
	if game_finished:
		return

	var new_state = not pause_state

	$pause.visible = new_state
	set_game_paused(new_state)

	if lang == "EN":
		$pause/title.text = "Setting"


func _on_Tutorial_pressed() -> void:
	$pause.visible = false
	$tutorial.visible = true

	set_game_paused(true)


func _on_Keluar_pressed() -> void:
	go_home()


func _on_hasil_close_pressed() -> void:
	go_home()


func go_home() -> void:
	if transitioning:
		return

	transitioning = true
	next_scene = HOME_SCENE

	$pause.visible = false
	$tutorial.visible = false
	$hasil.visible = false

	set_game_paused(false)
	$fade.doIn()


func _on_fade_animation_finished(_anim_name: String) -> void:
	if next_scene.is_empty():
		return

	var scene_path = next_scene
	next_scene = ""

	get_tree().change_scene_to_file(scene_path)


func _on_setting_close_pressed() -> void:
	$pause.visible = false
	set_game_paused(false)


func _on_tutorial_close_pressed() -> void:
	$tutorial.visible = false
	set_game_paused(false)


func _on_tutorial_close_btn() -> void:
	_on_tutorial_close_pressed()


# Collision and game-over handling

func _on_criticalArea_body_entered(body: Node2D) -> void:
	if game_finished:
		return

	if not body.has_method("get_fill"):
		return

	if not body.get_fill():
		kalah -= 1

		if kalah < 0:
			hasil("Coba Lagi", [""])
			return

	if body.name == "dna_" + str(nucleotide):
		hasil("Berhasil", [""])


func hasil(jenis: String, komentar: Array) -> void:
	if game_finished:
		return

	game_finished = true
	set_game_paused(true)

	$hasil.visible = true

	if jenis == "Berhasil":
		$hasil/title.text = (
			"Success" if lang == "EN" else "Berhasil"
		)

		$hasil/title.add_theme_color_override(
			"font_color", Color8(0, 255, 0)
		)

		var percent = (
			float(score) / float(nucleotide)
		)

		if lang == "EN":
			$hasil/label.text = (
				"Percentage: %.2f%%\n" % percent
				+ "Score: " + str(score) + "\n"
				+ "Correct answers: " + str(benar) + "\n"
				+ "Wrong answers: " + str(salah)
			)
		else:
			$hasil/label.text = (
				"Persentase: %.2f%%\n" % percent
				+ "Score: " + str(score) + "\n"
				+ "Jawaban benar: " + str(benar) + "\n"
				+ "Jawaban salah: " + str(salah)
			)

		$hasil/TextureRect.visible = false

	elif jenis == "Coba Lagi":
		$hasil/title.text = (
			"Try Again" if lang == "EN" else "Coba Lagi"
		)

		$hasil/title.add_theme_color_override(
			"font_color", Color8(255, 0, 0)
		)

		var message = (
			"Nukleotida A berpasangan dengan T, "
			+ "sedangkan G berpasangan dengan C"
		)

		if lang == "EN":
			message = translate_text("komentar_cobalagi")

		if komentar.size() >= 2 and str(komentar[0]) != "":
			var soal: String = str(komentar[0])
			var jawab: String = str(komentar[1])

			var pasangan = {
				"A": "T",
				"T": "A",
				"G": "C",
				"C": "G"
			}

			var expected = str(pasangan.get(soal, ""))

			if not expected.is_empty():
				if lang == "EN":
					message = (
						"Nucleotide " + soal
						+ " should pair with " + expected
						+ ", not with " + jawab
					)
				else:
					message = (
						"Nukleotida " + soal
						+ " seharusnya berpasangan dengan "
						+ expected
						+ ", bukan dengan " + jawab
					)

		$hasil/label.text = message
		$hasil/TextureRect.visible = true

	else:
		game_finished = false
		set_game_paused(false)
