extends Control

@onready var screen1 = $screen1
@onready var screen2 = $screen2

# Called when the node enters the scene tree for the first time.
func _ready():
	if not playerClass.littleGuys[1]["owned"] or not playerClass.littleGuys[1]["alive"]:
		$screen1/class1.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen1/class1/class1.disabled = true
	if not playerClass.littleGuys[2]["owned"] or not playerClass.littleGuys[2]["alive"]:
		$screen1/class2.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen1/class2/class2.disabled = true
	if not playerClass.littleGuys[3]["owned"] or not playerClass.littleGuys[3]["alive"]: 
		$screen1/class3.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen1/class3/class3.disabled = true
	if not playerClass.littleGuys[4]["owned"] or not playerClass.littleGuys[4]["alive"]:
		$screen1/class4.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen1/class4/class4.disabled = true
	if not playerClass.littleGuys[5]["owned"] or not playerClass.littleGuys[5]["alive"]:
		$screen1/class5.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen1/class5/class5.disabled = true
	if not playerClass.littleGuys[6]["owned"] or not playerClass.littleGuys[6]["alive"]:
		$screen1/class6.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen1/class6/class6.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_screens():
	if screen1.visible:
		playerClass.calc_stats_final()
		var player_stats = playerClass.updated_stats
		var player_items = playerClass.littleGuys[playerClass.playerClass]["items"]
		var control = $screen2/Control
		var index = 0
		
		var sprite = screen2.get_node("chosen_guy_sprite")
		var label = screen2.get_node("chosen_guy_name")
		
		
		if playerClass.playerClass == 1:
			sprite.texture = load("res://sprites/little_guy_1.png")
			label.text = "Knight Guy"
		elif playerClass.playerClass == 2:
			sprite.texture = load("res://sprites/little_guy_2.png")
			label.text = "Ninja Guy"
		elif playerClass.playerClass == 3:
			sprite.texture = load("res://sprites/little_guy_3.png")
			label.text = "Archer Guy"
		elif playerClass.playerClass == 4:
			sprite.texture = load("res://sprites/little_guy_4.png")
			label.text = "Thief Guy"
		elif playerClass.playerClass == 5:
			sprite.texture = load("res://sprites/little_guy_5.png")
			label.text = "King Guy"
		elif playerClass.playerClass == 6:
			sprite.texture = load("res://sprites/little_guy_1.png")
			label.text = "Template Guy"
		
		for node in control.get_children():
			if index == 4:
				break
			pass
			if index < len(player_items):
				node.text = str(player_items[index])
			else:
				node.text = "MISSING ITEM"
			
			index += 1
		
		screen2.get_node("individual_stats_label").text = "Health:                                    %s
Melee Damage:                        %s
Range Damage:                        %s
Speed:                                       %s
Melee Speed:                         %s
Range Speed:                         %s" % [str(player_stats["Health"]), str(player_stats["MeleeDamage"]), str(player_stats["RangeDamage"]), str(player_stats["Speed"]), str(player_stats["MeleeSpeed"]), str(player_stats["RangeSpeed"])]
	
	screen1.visible = not screen1.visible
	screen2.visible = not screen2.visible

func _on_class_1_pressed():
	playerClass.playerClass = 1
	switch_screens()


func _on_class_2_pressed():
	playerClass.playerClass = 2
	switch_screens()


func _on_class_3_pressed():
	playerClass.playerClass = 3
	switch_screens()


func _on_class_4_pressed():
	playerClass.playerClass = 4
	switch_screens()


func _on_class_5_pressed():
	playerClass.playerClass = 5
	switch_screens()


func _on_class_6_pressed():
	playerClass.playerClass = 6
	switch_screens()
	


func _on_ready_button_pressed():
	if not playerClass.game_paused:
		get_tree().change_scene_to_file("res://map_screen.tscn")
	else:
		switch_screens()
		get_parent().pause_game()


func _on_back_to_screen_1_pressed():
	switch_screens()
