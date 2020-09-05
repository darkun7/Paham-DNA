extends Node
var global_speed
var global_nucleotide
var kesulitan
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)

func set_global_speed(value:float):
	global_speed = value
func get_global_speed()->float:
	return global_speed

func set_global_nucleotide(value:int):
	global_nucleotide = value
func get_global_nucleotide()->int:
	return global_nucleotide

func set_global_kesulitan(value:String):
	kesulitan = value
func get_global_kesulitan()->String:
	return kesulitan