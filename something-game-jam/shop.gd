extends Control

var selected_item = 0
var selected_class = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $screen1/item_1/item_1.button_pressed:
		select_item(1)
		#playerClass.littleGuyItems[1].append(1)
	
	if $screen1/item_2/item_2.button_pressed:
		select_item(2)
	
	if $screen1/item_3/item_3.button_pressed:
		select_item(3)
	
	if $screen1/character_1/Button.button_pressed:
		print("Bought Character 1")
	
	if $screen1/character_2/Button.button_pressed:
		print("Bought Character 2")

func _on_map_pressed():
	get_tree().change_scene_to_file("res://map_screen.tscn")


func select_item(item_num):
	print("I BOUGHT ITEM %s" % item_num)
	selected_item = item_num
	
	$screen1.hide()
	$screen2.show()

func select_class(class_num):
	print("I SELECT CLASS %s" % class_num)
	selected_class = class_num
	
	playerClass.littleGuys[selected_class]["items"].append(selected_item)
	playerClass.playerClass = class_num
	print(playerClass.littleGuys)
	
	playerClass.calc_stats_final()
	var player_stats = playerClass.updated_stats
	var player_items = playerClass.littleGuys[playerClass.playerClass]["items"]
	var control = $screen3/Control
	var index = 0
	
	var sprite = $screen3.get_node("chosen_guy_sprite")
	var label = $screen3.get_node("chosen_guy_name")
	
	
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
		
	$screen3.get_node("individual_stats_label").text = "Health:                                    %s
Melee Damage:                        %s
Range Damage:                        %s
Speed:                                       %s
Melee Speed:                         %s
Range Speed:                         %s" % [str(player_stats["Health"]), str(player_stats["MeleeDamage"]), str(player_stats["RangeDamage"]), str(player_stats["Speed"]), str(player_stats["MeleeSpeed"]), str(player_stats["RangeSpeed"])]

	
	$screen2.hide()
	$screen3.show()
	
	

func _on_class_1_pressed():
	select_class(1)
	

func _on_class_2_pressed():
	select_class(2)


func _on_class_3_pressed():
	select_class(3)


func _on_class_4_pressed():
	select_class(4)


func _on_class_5_pressed():
	select_class(5)


func _on_class_6_pressed():
	select_class(6)


func _on_back_to_items_pressed():
	$screen2.hide()
	$screen1.show()
	selected_item = 0


func _on_confirm_purchase_pressed():
	$screen3.hide()
	$screen1.show()


func _on_back_to_classes_pressed():
	pass # Replace with function body.
