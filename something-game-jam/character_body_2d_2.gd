extends CharacterBody2D

@export_enum("IDLE", "ATTACKING", "RETREATING") var npc_state

var health = 10
@onready var bullet = $bullet
var canShoot = true

@export var movement_speed = 200

@onready var nav_agent = $NavigationAgent2D
@onready var player = get_tree().current_scene.get_node("player")
@onready var direction : Vector2


func _ready():
	var random = RandomNumberGenerator.new()
	global_position = Vector2(random.randi_range(100, 1000), random.randi_range(100, 550))
	$ShootCoolDown.autostart = true
	if $hitpoints.label_settings:
		$hitpoints.label_settings = $hitpoints.label_settings.duplicate()
	$hitpoints.label_settings.font_color = Color(0, 255, 0)

func _physics_process(delta: float) -> void:
	if self.health < 1:
		queue_free()
	
	$hitpoints.text = str(health)
	if health <= 3:
		$hitpoints.label_settings.font_color = Color(255, 0, 0)
	elif health <= 7:
		$hitpoints.label_settings.font_color = Color(255, 255, 0)
	else:
		$hitpoints.label_settings.font_color = Color(0, 255, 0)
	
	# Connects the timeout to the function so that we don't call it every frame and can instead just use a
	#  repeated timer while still having access to delta
	$ShootCoolDown.connect("timeout", shoot.bind(delta))
	
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
	
	#if global_position.distance_to(get_parent().get_node("player").global_position) > 200:
		#global_position = global_position.move_toward(get_parent().get_node("player").global_position, 200 * delta)
	#else:
		#shoot(delta)
	move_and_slide()


func shoot(delta):
	if canShoot:
		canShoot = false
		var copyb = bullet.duplicate()
		$enemy_bullets.add_child(copyb)
		copyb.name = "bullet"
		var direction = (get_parent().get_parent().get_node("player").global_position - global_position).normalized()
		copyb.global_position = global_position
		copyb.direction = direction
		await get_tree().create_timer(.2).timeout
		
		copyb.visible = true
		copyb.get_node("Timer").start() #Will start timer to remove bullet from scene after 1 seconds
		
		$ShootCoolDown.start(.5)


func _on_shoot_cool_down_timeout() -> void:
	canShoot = true
