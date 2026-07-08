extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_map_pressed():
	get_tree().change_scene_to_file("res://map.tscn")


func _on_item_1_pressed():
	print("I BOUGHT ITEM 1")


func _on_item_2_pressed():
	print("I BOUGHT ITEM 2")


func _on_item_3_pressed():
	print("I BOUGHT ITEM 3")
