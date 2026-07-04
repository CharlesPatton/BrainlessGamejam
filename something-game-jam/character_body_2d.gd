extends CharacterBody2D

@onready var bullet = $bullet
@onready var weapon = $weapon
var canShoot = true
var canSwing = true

#PLAYER THINGS
var HEALTH = 20
var MELEE_DAMAGE = 2
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
		copyb.position = self.position
		var direction = (get_global_mouse_position() - global_position).normalized()
		copyb.direction = direction
		get_tree().current_scene.add_child(copyb)
		copyb.visible = true
		
		$ShootCoolDown.start(.25)
	
	if Input.is_action_just_pressed("swing") and canSwing:
		canSwing = false
		weapon.show()
		weapon.rotate(weapon.get_angle_to(get_global_mouse_position()) - PI/6)
		
		var tween = get_tree().create_tween()
		tween.tween_property(weapon, "rotation", weapon.rotation + (PI/3), 0.5)
		
		await get_tree().create_timer(0.5).timeout
		endSwing()


func endSwing():
	weapon.hide()
	weapon.rotation = 0
	$swingCooldown.start()
	

func _on_shoot_cool_down_timeout() -> void:
	canShoot = true


func _on_swing_cooldown_timeout():
	canSwing = true
