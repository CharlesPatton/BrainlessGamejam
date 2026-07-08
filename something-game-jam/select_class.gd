extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_class_1_pressed():
	playerClass.playerClass = 1
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_class_2_pressed():
	playerClass.playerClass = 2
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_class_3_pressed():
	playerClass.playerClass = 3
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_class_4_pressed():
	playerClass.playerClass = 4
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_class_5_pressed():
	playerClass.playerClass = 5
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_class_6_pressed():
	playerClass.playerClass = 6
	get_tree().change_scene_to_file("res://node_2d.tscn")
