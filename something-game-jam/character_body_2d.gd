extends CharacterBody2D

@onready var bullet = $bullet
@onready var weapon = $weapon
var canShoot = true
var canSwing = true

var player_stats = playerClass.updated_stats

func _process(delta: float) -> void:
	move_player()
	shoot(delta)


func move_player():
	if Input.is_action_pressed("up"):
		self.position.y -= 1 * player_stats["Speed"]
		
	if Input.is_action_pressed("down"):
		self.position.y += 1 * player_stats["Speed"]
		
	if Input.is_action_pressed("left"):
		self.position.x -= 1 * player_stats["Speed"]
		
	if Input.is_action_pressed("right"):
		self.position.x += 1 * player_stats["Speed"]


func shoot(delta):
	if Input.is_action_pressed("shoot") and canShoot:
		print("SHOOTING")
		canShoot = false
		var copyb = bullet.duplicate()
		$player_bullets.add_child(copyb)
		copyb.show()
		copyb.global_position = global_position
		var direction = (get_global_mouse_position() - global_position).normalized()
		copyb.direction = direction
		
		print(global_position)
		print(copyb.global_position)
		
		copyb.visible = true
		copyb.get_node("Timer").start() #Will start timer to remove bullet from scene after 1 seconds
		
		
		$ShootCoolDown.start(player_stats["RangeSpeed"])
	
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
		
		var tween = get_tree().create_tween()
		tween.tween_property(weapon, "rotation", weapon.rotation + (2 * PI/3), player_stats["MeleeSpeed"])
		
		await get_tree().create_timer(player_stats["MeleeSpeed"]).timeout
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
	print(area.name)
	if area.get_node("enemyBulletCollision"):
		pass
		#print("hit")
		#player_stats["Health"] -= 1
	if area.get_node("enemy_weapon_collision"):
		print("Stabbed")
		#player_stats["Health"] -= 4
	if area.get_node("bomb_collision"):
		print("Collided with bomb")
		area.get_parent().explode_bomb()


func _on_weapon_body_entered(body):
	if body.get_parent().name == "enemies":
		#print("HIT ENEMY MELEE")
		body.health -= player_stats["MeleeDamage"]
		print(player_stats["MeleeDamage"])


func _on_bullet_body_entered(body):
	if body.get_parent().name == "enemies":
		#print("HIT ENEMY RANGED")
		body.health -= player_stats["RangeDamage"]
		print(player_stats["RangeDamage"])
