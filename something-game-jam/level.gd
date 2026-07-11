extends Node2D

var map = playerClass.map
var num_enemies = playerClass.num_enemies
# var reward maybe be just true random items that you can put on 
var numberOfRounds = playerClass.numberOfRounds
var isBossRoom = false


@onready var enemies = $enemies
@onready var melee_enemy = $enemies/melee_enemy.duplicate()
@onready var ranged_enemy = $enemies/enemy.duplicate()
@onready var bomb_enemy = $enemies/bomb_enemy.duplicate()
@onready var player = $player
@onready var selectClass = $selectClass

var char_select = preload("res://select_class.tscn")

var random = RandomNumberGenerator.new()

var enemies_spawned = 0
var curr_round = 1

func _ready():
	
	$enemies/enemy.queue_free()
	$enemies/melee_enemy.queue_free()
	$enemies/bomb_enemy.queue_free()
	initialize_round()


func _process(delta: float) -> void:
	if Input.is_action_pressed("pause"):
		pause_game()
	
	if enemies.get_child_count() == 0 and num_enemies == enemies_spawned:
		print("ENEMIES GONE")
		if curr_round == numberOfRounds:
			get_tree().change_scene_to_file("res://map.tscn")
		curr_round += 1
		
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
	for i in range(num_enemies):
		var enemy_type = random.randi_range(1, 3)
		if enemy_type % 3 == 0:
			enemies.add_child(melee_enemy)
			melee_enemy.show()
			melee_enemy.health = 10
			melee_enemy.name = "melee_enemy"
			melee_enemy = $enemies.get_node("melee_enemy")
			enemies_spawned += 1
		elif enemy_type % 3 == 1:
			enemies.add_child(ranged_enemy)
			ranged_enemy.show()
			ranged_enemy.health = 10
			ranged_enemy.name = "ranged_enemy"
			ranged_enemy = $enemies.get_node("ranged_enemy")
			enemies_spawned += 1
		else:
			enemies.add_child(bomb_enemy)
			bomb_enemy.show()
			bomb_enemy.health = 10
			bomb_enemy.name = "bomb_enemy"
			bomb_enemy = $enemies.get_node("bomb_enemy")
			enemies_spawned += 1
		await get_tree().create_timer(2).timeout
