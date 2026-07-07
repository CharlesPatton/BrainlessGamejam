extends Node2D

@onready var level1 = $level1
@onready var level2 = $level2
@onready var level3 = $level3
@onready var level4 = $level4
@onready var level5 = $level5 # boss area

#all these map names are temporary
func _ready() -> void:
	level1.enemies = 3
	level1.numberOfRounds = 3
	level1.map = "blank"
	level1.next_level = level2
	
	level2.enemies = 4
	level2.numberOfRounds = 4
	level2.map = "2shields"
	level2.next_level = level3
	
	level3.enemies = 5
	level3.numberOfRounds = 5
	level3.map = "coolMap"
	level3.next_level = level4
	
	level4.enemies = 10
	level4.numberOfRounds = 5
	level4.map = "blank"
	level4.next_level = level5
	
	level5.isBossRoom = true
	level5.next_level = level1 #make it the next map
	level5.enemies = 1
	level5.numberOfRounds = 1 
	
	
