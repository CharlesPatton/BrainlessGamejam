extends Node2D

@onready var level1 = $level1
@onready var level2 = $level2
@onready var level3 = $level3
@onready var level4 = $level4
@onready var level5 = $level5 # boss area

var globalObject = playerClass

#all these map names are temporary
func _ready() -> void:
	print("READY")
	level2.modulate = Color(125, 0, 0)
	level3.modulate = Color(125, 0, 0)
	level4.modulate = Color(125, 0, 0)
	level5.modulate = Color(125, 0, 0)
	
	
	if globalObject.levels_beaten > 0:
		level1.modulate = Color(0, 125, 0)
		level2.modulate = Color(0, 0, 0)
	
	if globalObject.levels_beaten > 1:
		level2.modulate = Color(0, 125, 0)
		level3.modulate = Color(0, 0, 0)
	
	if globalObject.levels_beaten > 2:
		level3.modulate = Color(0, 125, 0)
		level4.modulate = Color(0, 0, 0)
	
	if globalObject.levels_beaten > 3:
		level4.modulate = Color(0, 125, 0)
		level5.modulate = Color(0, 0, 0)
	
	if globalObject.levels_beaten > 4:
		level5.modulate = Color(0, 125, 0)
		print("YOU WIN!")
	
	
func _process(delta: float) -> void:
	if globalObject.levels_beaten > 0:
		$shop.show()
	
	if $level1/Button.button_pressed:
		if globalObject.levels_beaten == 0:
			globalObject.num_enemies = 3
			globalObject.numberOfRounds = 3
			globalObject.map = "blank"
			get_tree().change_scene_to_file("res://levels/world1/level1.tscn")
		else:
			flash_button_error($level1)
		
	if $level2/Button.button_pressed:
		if globalObject.levels_beaten == 1:
			globalObject.num_enemies = 4
			globalObject.numberOfRounds = 4
			globalObject.map = "2shields"
			get_tree().change_scene_to_file("res://levels/world1/level2.tscn")
		else:
			flash_button_error($level2)
		
	if $level3/Button.button_pressed:
		if globalObject.levels_beaten == 2:
			globalObject.num_enemies = 5
			globalObject.numberOfRounds = 5
			globalObject.map = "coolMap"
			get_tree().change_scene_to_file("res://levels/world1/level3.tscn")
		else:
			flash_button_error($level3)
		
	if $level4/Button.button_pressed:
		if globalObject.levels_beaten == 3:
			globalObject.num_enemies = 10
			globalObject.numberOfRounds = 5
			globalObject.map = "blank"
			get_tree().change_scene_to_file("res://levels/world1/level4.tscn")
		else:
			flash_button_error($level4)
		
	if $level5/Node2D/Button.button_pressed:
		if globalObject.levels_beaten == 4:
			#level5.isBossRoom = true
			#level5.next_level = level1 #make it the next map
			#level5.num_enemies = 1
			#level5.numberOfRounds = 1
			get_tree().change_scene_to_file("res://levels/world1/level5.tscn")
		else:
			flash_button_error($level5)



func flash_button_error(level):
	var og_color = level.modulate
	level.modulate = Color(125, 0, 0)
	await get_tree().create_timer(0.5).timeout
	level.modulate = og_color


func _on_button_pressed():
	get_tree().change_scene_to_file("res://shop.tscn")
