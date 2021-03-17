extends Control

signal close_btn

var lang = "EN"

# Called when the node enters the scene tree for the first time.
func _ready():
	if lang == "EN":
		$label.text = "Find the nucleotide pair of the lowermost block. Use the buttons at the bottom to select a suitable nucleotide pair. Adenine pairs with Thymine, while Guanine pairs with Cytosine."
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_close_pressed():
	emit_signal("close_btn")
