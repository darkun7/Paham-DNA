
extends CharacterBody2D

# DNA properties
@export var gene: String = "A"
@export var jenis: String = ""
@export var gene_ans: String = ""
@export var size: int = 1
@export var speed: float = 50.0
@export var isfilled: bool = false


func _ready() -> void:
	# Initialize movement
	velocity = Vector2(0.0, speed)


func _physics_process(_delta: float) -> void:
	# Move downward using the configured speed
	velocity = Vector2(0.0, speed)
	move_and_slide()


# Fill state

func get_fill() -> bool:
	return isfilled


func set_fill(value: bool) -> void:
	isfilled = value


# Gene

func get_gene() -> String:
	return gene


func set_gene(value: String) -> void:
	gene = value


# Answer gene

func get_gene_ans() -> String:
	return gene_ans


func set_gene_ans(value: String) -> void:
	gene_ans = value


# DNA type

func get_jenis() -> String:
	return jenis


func set_jenis(value: String) -> void:
	jenis = value


# DNA size

func get_size() -> int:
	return size


func set_size(value: int) -> void:
	size = value


# Movement speed
# Custom method names prevent collisions with
# CharacterBody2D's built-in velocity methods.

func get_move_speed() -> float:
	return speed


func set_move_speed(value: float) -> void:
	speed = value
	velocity.y = speed


func stop_movement() -> void:
	speed = 0.0
	velocity = Vector2.ZERO
