extends CharacterBody2D

var health = 10
@onready var bullet = $bullet
var canShoot = true

func _physics_process(delta: float) -> void:
	if health < 1:
		get_parent().remove_child($enemy)
		
	if global_position.distance_to(get_parent().get_node("player").global_position) > 200:
		global_position = global_position.move_toward(get_parent().get_node("player").global_position, 200 * delta)
	else:
		shoot(delta)
	
	move_and_slide()
	
	pass


func shoot(delta):
	if canShoot:
		canShoot = false
		var copyb = bullet.duplicate()
		var direction = (get_parent().get_node("player").global_position - global_position).normalized()
		copyb.position = self.position
		copyb.direction = direction
		await get_tree().create_timer(.2).timeout
		get_tree().current_scene.add_child(copyb)
		copyb.visible = true
		
		$ShootCoolDown.start(.15)


func _on_shoot_cool_down_timeout() -> void:
	canShoot = true


func _on_hit_shape_area_entered(area: Area2D) -> void:
	print(health)
	health -= 1
