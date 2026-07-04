extends Node2D

@onready var copyEnemy = $enemy.duplicate()

func _process(delta: float) -> void:
	if not $enemy:
		get_tree().change_scene_to_file("res://map.tscn")
