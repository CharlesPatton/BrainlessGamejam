extends Node2D

@onready var enemies = $enemies
@onready var copyEnemy = $enemies/enemy.duplicate()
@onready var player = $player
@onready var selectClass = $selectClass

var char_select = preload("res://select_class.tscn")

var random = RandomNumberGenerator.new()
var num_enemies = 0
var enemies_spawned = 0

func _ready():
	initialize_encounter(true)


func _process(delta: float) -> void:
	if Input.is_action_pressed("pause"):
		pause_game()
		
	
	if enemies.get_child_count() == 0 and num_enemies * 2 == enemies_spawned:
		print("ENEMIES GONE")
		get_tree().change_scene_to_file("res://map.tscn")
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


func initialize_encounter(normal_fight: bool):
	if normal_fight:
		num_enemies = random.randi_range(3, 6)
		if num_enemies % 2 == 1:
			num_enemies += 1
	else:
		start_boss_fight()
	
	#for i in range(num_enemies):
		#await get_tree().create_timer(4).timeout
		#add_enemy()
		#add_enemy()


func add_enemy():
	enemies.add_child(copyEnemy)
	copyEnemy.show()
	copyEnemy.health = 10
	copyEnemy = $enemies.get_child(0).duplicate()
	enemies_spawned += 1


func start_boss_fight():
	pass


func _on_enemy_timer_timeout():
	if enemies_spawned < num_enemies * 2:
		add_enemy()
		add_enemy()
