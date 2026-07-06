extends CharacterBody2D

@onready var bullet = $bullet
@onready var weapon = $weapon
var canShoot = true
var canSwing = true

#PLAYER THINGS
var HEALTH = 20
var MELEE_DAMAGE = 2
var SWING_SPEED = 0.2
var RANGE_DAMAGE = 1
var SPEED = 3


func _process(delta: float) -> void:
	move_player()
	shoot(delta)
	
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
		
		$ShootCoolDown.start(.25)
	
	if Input.is_action_just_pressed("swing") and canSwing:
		canSwing = false
		weapon.show()
		
		#gets angle of mouse in relation to weapon and rotates weapon to that angle
		var direction = weapon.get_angle_to(get_global_mouse_position())
		weapon.rotate(direction)
		weapon.move_local_x(20) #offset variable, can change if needed
		
		#rotates to starting angle and then tweens by SWING_SPEED to final angle
		weapon.rotate(-PI/3)
		print(weapon.rotation * 180/PI)
		
		var tween = get_tree().create_tween()
		tween.tween_property(weapon, "rotation", weapon.rotation + (2 * PI/3), SWING_SPEED)
		
		await get_tree().create_timer(SWING_SPEED).timeout
		print(weapon.rotation * 180/PI)
		endSwing()


func endSwing():
	weapon.hide()
	weapon.rotation = 0
	weapon.global_position = global_position + Vector2(1, -5)
	$swingCooldown.start()
	

func _on_shoot_cool_down_timeout() -> void:
	canShoot = true


func _on_swing_cooldown_timeout():
	canSwing = true


func _on_bullet_area_entered(area):
	#HEALTH -= 1
	pass


func _on_player_hit_box_area_entered(area):
	print(area.name)
	if area.name == "bullet":
		print("hit")
