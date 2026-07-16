extends Control

var selected_item = 0
var selected_class = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if not playerClass.littleGuys[1]["owned"] or not playerClass.littleGuys[1]["alive"]:
		$screen2/class1.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen2/class1/class1.disabled = true
	if not playerClass.littleGuys[2]["owned"] or not playerClass.littleGuys[2]["alive"]:
		$screen2/class2.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen2/class2/class2.disabled = true
	if not playerClass.littleGuys[3]["owned"] or not playerClass.littleGuys[3]["alive"]: 
		$screen2/class3.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen2/class3/class3.disabled = true
	if not playerClass.littleGuys[4]["owned"] or not playerClass.littleGuys[4]["alive"]:
		$screen2/class4.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen2/class4/class4.disabled = true
	if not playerClass.littleGuys[5]["owned"] or not playerClass.littleGuys[5]["alive"]:
		$screen2/class5.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen2/class5/class5.disabled = true
	if not playerClass.littleGuys[6]["owned"] or not playerClass.littleGuys[6]["alive"]:
		$screen2/class6.modulate = Color(1.0, 1.0, 1.0, 0.500)
		$screen2/class6/class6.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$coins_screen/coins.text = str(playerClass.coins)
	
	if $screen1/item_1/item_1.button_pressed:
		select_item(1)
	
	if $screen1/item_2/item_2.button_pressed:
		select_item(2)
	
	if $screen1/item_3/item_3.button_pressed:
		select_item(3)
	
	if $screen1/item_4/item_4.button_pressed:
		select_item(4)
	
	if $screen1/item_5/item_5.button_pressed:
		select_item(5)

func _on_map_pressed():
	get_tree().change_scene_to_file("res://map_screen.tscn")


func select_item(item_num):
	if playerClass.coins < 25:
		$error/Label.show()
		$error/Label.text = "Not Enough Coins For Purchase"
		await get_tree().create_timer(2).timeout
		$error/Label.hide()
		return
	
	
	print("I BOUGHT ITEM %s" % item_num)
	selected_item = item_num
	
	$screen1.hide()
	$screen2.show()

func select_class(class_num):
	if len(playerClass.littleGuys[class_num]["items"]) == 4:
		$error/Label.show()
		$error/Label.text = "All Item Slots Filled For This Class"
		await get_tree().create_timer(2).timeout
		$error/Label.hide()
		return
	
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
	playerClass.coins -= 25


func _on_back_to_classes_pressed():
	playerClass.littleGuys[playerClass.playerClass]["items"].pop_back()
	playerClass.calc_stats_final()
	selected_class = 0
	$screen3.hide()
	$screen2.show()
