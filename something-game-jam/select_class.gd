extends Control

@onready var screen1 = $screen1
@onready var screen2 = $screen2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_screens():
	if screen1.visible:
		var player_items = playerClass.littleGuyItems[playerClass.playerClass]
		var control = $screen2/Control
		var index = 0
		
		for node in control.get_children():
			if index == 4:
				break
			pass
			if index < len(player_items):
				node.text = str(player_items[index])
			else:
				node.text = "MISSING ITEM"
			
			index += 1
	
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
	var stats = screen2.get_node("individual_stats_label")
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_back_to_screen_1_pressed():
	switch_screens()
