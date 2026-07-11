extends CharacterBody2D

@export_enum("IDLE", "ATTACKING", "RETREATING") var npc_state

var health = 7
var bomb_placed = false

@export var movement_speed = 200

@onready var nav_agent = $NavigationAgent2D
@onready var player = get_tree().current_scene.get_node("player")
@onready var direction : Vector2
@onready var bomb = $bomb
@onready var explosion = $explosion


func _ready():
	var random = RandomNumberGenerator.new()
	global_position = Vector2(random.randi_range(100, 1000), random.randi_range(100, 550))
	if $hitpoints.label_settings:
		$hitpoints.label_settings = $hitpoints.label_settings.duplicate()
	$hitpoints.label_settings.font_color = Color(0, 255, 0)


func _physics_process(delta: float) -> void:
	if self.health < 1:
		queue_free()
	
	$hitpoints.text = str(health)
	if health <= 2:
		$hitpoints.label_settings.font_color = Color(255, 0, 0)
	elif health <= 5:
		$hitpoints.label_settings.font_color = Color(255, 255, 0)
	else:
		$hitpoints.label_settings.font_color = Color(0, 255, 0)
	
	# Sets the target position as the player no matter what state it's in
	nav_agent.target_position = player.global_position
	
	match npc_state:
		# Later on we might wanna add a class type as well to determine how they actually fight
		# but this is good for a melee character, they just attack and retreat when their health is low
		"ATTACKING":
			direction = global_position.direction_to(nav_agent.get_next_path_position())
			velocity = velocity.lerp(direction * movement_speed, delta)
		"RETREATING":
			direction = global_position.direction_to(nav_agent.get_next_path_position())
			velocity = velocity.lerp(direction * -movement_speed, delta)
	
	if health < 3:
		npc_state = "RETREATING"
	else:
		npc_state = "ATTACKING"
	
	if bomb_placed:
		#move around while bomb is in place
		pass
	
	move_and_slide()


func _on_bomb_timer_timeout():
	print("Starting Explosion")
	bomb.show()
	bomb.get_node("bomb_collision").disabled = false
	
	await get_tree().create_timer(3).timeout
	
	explode_bomb()


func explode_bomb():
	print("Explosion")
	bomb.hide()
	bomb.get_node("bomb_collision").disabled = true
	
	explosion.show()
	explosion.get_node("explosion_collision").disabled = false
	
	
	
	await get_tree().create_timer(0.25).timeout
	
	for area in $explosion.get_overlapping_areas():
		if area.name == "playerHitBox":
			playerClass.updated_stats["Health"] -= 7
			print("Blown Up")
	
	end_explosion()
	
	
func end_explosion():
	print("Ending Explosion")
	explosion.hide()
	explosion.get_node("explosion_collision").disabled = true
	
	$bombTimer.start()
