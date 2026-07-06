extends Node2D

@onready var enemies = $enemies
@onready var copyEnemy = $enemies/enemy.duplicate()
@onready var player = $player
var random = RandomNumberGenerator.new()

func _ready():
	var num_enemies = random.randi_range(3, 10)
	for i in range(num_enemies):
		await get_tree().create_timer(5 + i).timeout
		enemies.add_child(copyEnemy)
		

func _process(delta: float) -> void:
	if enemies.get_child_count() == 0:
		print("ENEMIES GONE")
		get_tree().change_scene_to_file("res://map.tscn")
	elif player.HEALTH <= 0:
		print("DIED")
		get_tree().change_scene_to_file("res://map.tscn")
