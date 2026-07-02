extends Area2D

@export var speed := 1250.0
var direction = transform.x

func _physics_process(delta):
	global_position += speed * delta * direction

func visibility(bool):
	visible = bool
