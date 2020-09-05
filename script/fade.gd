extends AnimationPlayer
signal fade_finished
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func doIn():
	$color.visible = true
	play("in")

func doOut():
	$color.visible = true
	play("out")

func _on_fade_animation_finished(anim_name):
	if(anim_name=="in"):
		emit_signal("fade_finished")
