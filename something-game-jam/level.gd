extends Node2D

var map = playerClass.map
var num_enemies = playerClass.num_enemies
# var reward maybe be just true random items that you can put on 
var numberOfRounds = playerClass.numberOfRounds
var isBossRoom = false


@onready var enemies = $enemies
@onready var melee_enemy = preload("res://melee_enemy.tscn")
@onready var ranged_enemy = preload("res://ranged_enemy.tscn")
@onready var bomb_enemy = preload("res://bomb_enemy.tscn")
@onready var player = $player
@onready var selectClass = $selectClass

var random = RandomNumberGenerator.new()

var enemies_spawned = 0
var curr_round = 0

func _ready():
	initialize_round()
	print()


func _process(delta: float) -> void:
	if Input.is_action_pressed("pause"):
		pause_game()
	
	if enemies.get_child_count() == 0 and num_enemies == enemies_spawned:
		print("ENEMIES GONE")
		if curr_round == numberOfRounds:
			playerClass.levels_beaten += 1
			get_tree().change_scene_to_file("res://shop.tscn")
		print("NEW ROUND")
		enemies_spawned = 0
		initialize_round()
		
	elif player.player_stats["Health"] <= 0:
		print("DIED")
		get_tree().change_scene_to_file("res://map.tscn")

func pause_game():
	print("Change Character")
	get_tree().paused = not get_tree().paused
	playerClass.game_paused = not playerClass.game_paused
	selectClass.visible = not selectClass.visible
	player.visible = not player.visible
	enemies.visible = not enemies.visible
	player.player_stats = playerClass.updated_stats


func initialize_round():
	curr_round += 1
	for i in range(num_enemies):
		var enemy_type = i + 1 #random.randi_range(1, 3)
		print("------")
		print("SPAWNING ENEMY")
		print(enemy_type)
		print("------")
		
		if enemy_type % 3 == 0:
			var new_enemy = melee_enemy.instantiate()
			enemies.add_child(new_enemy)
			new_enemy.show()
			new_enemy.health = 15
			enemies_spawned += 1
		elif enemy_type % 3 == 1:
			var new_enemy = ranged_enemy.instantiate()
			enemies.add_child(new_enemy)
			new_enemy.show()
			new_enemy.health = 10
			enemies_spawned += 1
		elif enemy_type % 3 == 2:
			var new_enemy = bomb_enemy.instantiate()
			enemies.add_child(new_enemy)
			new_enemy.show()
			new_enemy.health = 7
			enemies_spawned += 1
