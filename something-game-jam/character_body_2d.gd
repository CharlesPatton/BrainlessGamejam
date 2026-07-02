extends CharacterBody2D

@onready var bullet = $bullet
var canShoot = true

func _process(delta: float) -> void:
	move_player()
	shoot(delta)


func move_player():
	if Input.is_action_pressed("up"):
		self.position.y -= 1
		
	if Input.is_action_pressed("down"):
		self.position.y += 1
		
	if Input.is_action_pressed("left"):
		self.position.x -= 1
		
	if Input.is_action_pressed("right"):
		self.position.x += 1


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
		


func _on_shoot_cool_down_timeout() -> void:
	canShoot = true
