extends CharacterBody2D

@export_enum("IDLE", "ATTACKING", "RETREATING") var npc_state

var health = 15

@export var movement_speed = 200

@onready var nav_agent = $NavigationAgent2D
@onready var player = get_tree().current_scene.get_node("player")
@onready var direction : Vector2
@onready var weapon = $enemy_weapon

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
	if health <= 5:
		$hitpoints.label_settings.font_color = Color(255, 0, 0)
	elif health <= 10:
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
	
	if health < 6:
		npc_state = "RETREATING"
	else:
		npc_state = "ATTACKING"
	
	move_and_slide()
	

func _on_swing_cooldown_timeout():
	print("Swinging")
	weapon.show()
	weapon.get_node("enemy_weapon_collision").disabled = false
	
	
	#gets angle of mouse in relation to weapon and rotates weapon to that angle
	var direction = weapon.get_angle_to(player.global_position)
	weapon.rotate(direction)
	weapon.move_local_x(20) #offset variable, can change if needed
		
	#rotates to starting angle and then tweens by SWING_SPEED to final angle
	weapon.rotate(-PI/3)
		
	var tween = get_tree().create_tween()
	tween.tween_property(weapon, "rotation", weapon.rotation + (2 * PI/3), 0.3)
		
	await get_tree().create_timer(0.3).timeout
	
	end_swing()


func end_swing():
	weapon.hide()
	weapon.get_node("enemy_weapon_collision").disabled = true
	weapon.rotation = 0
	weapon.global_position = global_position + Vector2(1, -5)
	$swingCooldown.start()
