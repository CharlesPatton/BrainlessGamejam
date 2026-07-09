extends CharacterBody2D

@onready var bullet = $bullet
@onready var weapon = $weapon
var canShoot = true
var canSwing = true

#PLAYER THINGS
var HEALTH = 20
var MELEE_DAMAGE = 4
var RANGE_DAMAGE = 1
var SWING_SPEED = 0.2
var SHOOT_SPEED = 0.25
var SPEED = 3

func _process(delta: float) -> void:
	move_player()
	shoot(delta)

func initialize_class(classType: int):
	if classType == 1: #strong melee
		HEALTH *= 2
		MELEE_DAMAGE *= 2 
		SPEED /= 2
	elif classType == 2:  #fast melee
		HEALTH /= 2
		SPEED *= 2
		SWING_SPEED /= 2
	elif classType == 3: # strong ranged
		HEALTH *= 2
		SPEED /= 2
		RANGE_DAMAGE *= 2
	elif classType == 4: #fast ranged
		SPEED *= 2
		HEALTH /= 2
		SHOOT_SPEED /= 2
	elif classType == 5: #all around fast
		SWING_SPEED /= 2
		SHOOT_SPEED /= 2
		HEALTH /= 2
		SPEED /= 2
	elif classType == 6:
		HEALTH *= 2
		SPEED *= 2
		SWING_SPEED *= 2
		SHOOT_SPEED *= 2
	
	if classType < 1 or classType > 6:
		print("Class is Unknown")
	else:
		print("I am class " + str(classType))
	
	print("___")
	print(HEALTH)
	print(MELEE_DAMAGE)
	print(RANGE_DAMAGE)
	print(SWING_SPEED)
	print(SHOOT_SPEED)
	print(SPEED)
	print("___")

func initialize_items(items_list):
	print(items_list)
	for item in items_list:
		if item == 1:
			HEALTH += 7
	
	print("___")
	print(HEALTH)
	print(MELEE_DAMAGE)
	print(RANGE_DAMAGE)
	print(SWING_SPEED)
	print(SHOOT_SPEED)
	print(SPEED)
	print("___")

func move_player():
	if Input.is_action_pressed("up"):
		self.position.y -= 1 * SPEED
		
	if Input.is_action_pressed("down"):
		self.position.y += 1 * SPEED
		
	if Input.is_action_pressed("left"):
		self.position.x -= 1 * SPEED
		
	if Input.is_action_pressed("right"):
		self.position.x += 1 * SPEED


func shoot(delta):
	if Input.is_action_pressed("shoot") and canShoot:
		canShoot = false
		var copyb = bullet.duplicate()
		copyb.show()
		copyb.position = self.position
		var direction = (get_global_mouse_position() - global_position).normalized()
		copyb.direction = direction
		get_tree().current_scene.add_child(copyb)
		copyb.visible = true
		copyb.get_node("Timer").start() #Will start timer to remove bullet from scene after 1 seconds
		
		$ShootCoolDown.start(SHOOT_SPEED)
	
	if Input.is_action_just_pressed("swing") and canSwing:
		canSwing = false
		weapon.show()
		weapon.get_node("CollisionShape2D").disabled = false
		
		#gets angle of mouse in relation to weapon and rotates weapon to that angle
		var direction = weapon.get_angle_to(get_global_mouse_position())
		weapon.rotate(direction)
		weapon.move_local_x(20) #offset variable, can change if needed
		
		#rotates to starting angle and then tweens by SWING_SPEED to final angle
		weapon.rotate(-PI/3)
		#print(weapon.rotation * 180/PI)
		
		var tween = get_tree().create_tween()
		tween.tween_property(weapon, "rotation", weapon.rotation + (2 * PI/3), SWING_SPEED)
		
		await get_tree().create_timer(SWING_SPEED).timeout
		#print(weapon.rotation * 180/PI)
		endSwing()


func endSwing():
	weapon.hide()
	weapon.get_node("CollisionShape2D").disabled = true
	weapon.rotation = 0
	weapon.global_position = global_position + Vector2(1, -5)
	$swingCooldown.start()
	

func _on_shoot_cool_down_timeout() -> void:
	canShoot = true


func _on_swing_cooldown_timeout():
	canSwing = true


func _on_player_hit_box_area_entered(area):
	if area.get_node("enemyBulletCollision"):
		pass
		#print("hit")
		#HEALTH -= 1	


func _on_weapon_body_entered(body):
	if body.get_parent().name == "enemies":
		#print("HIT ENEMY MELEE")
		body.health -= MELEE_DAMAGE


func _on_bullet_body_entered(body):
	if body.get_parent().name == "enemies":
		#print("HIT ENEMY RANGED")
		body.health -= MELEE_DAMAGE
