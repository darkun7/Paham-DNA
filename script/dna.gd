extends KinematicBody2D

export(String) var gene setget set_gene, get_gene
export(String) var jenis setget set_jenis, get_jenis
export(String) var gene_ans setget set_gene_ans, get_gene_ans
export(int) var size setget set_size, get_size
export(int) var speed setget set_speed, get_speed
export(bool) var isfilled = false setget set_fill, get_fill

var velocity = Vector2()

func _ready():
	print(speed)
	velocity.y = 50
	velocity.x = 0
	pass

func get_fill()->bool:
	return isfilled
func set_fill(value:bool)->void:
	isfilled = value
	pass

func get_gene()->String:
	return gene
func set_gene(value:String)->void:
	gene = value
	pass

func get_gene_ans()->String:
	return gene_ans
func set_gene_ans(value:String)->void:
	gene_ans = value
	pass

func get_jenis()->String:
	return jenis
func set_jenis(Value:String)->void:
	jenis = Value
	pass

func get_speed()->int:
	return speed
func set_speed(value:int)->void:
	speed = value
	pass

func get_size()->int:
	return size
func set_size(value:int)->void:
	size = value
	pass

func _physics_process(delta):
	print(velocity.y)
	move_and_slide(velocity)
