extends Node

#Base Stats that get manipulated later
var base_stats = {
	"Health": 20,
	"MeleeDamage": 4,
	"RangeDamage": 1,
	"Speed": 3,
	"MeleeSpeed": 0.25,
	"RangeSpeed": 0.2,
}

#The updated stats that gets used in game
var updated_stats = {}

#THE CLASS THE PLAYER CHOOSES TO PLAY AS DURING ENCOUNTER
var playerClass = 0

#GLOBAL STORAGE FOR ITEMS FOR EACH LITTLE GUY
var littleGuyItems = {
	1: [1, 2],
	2: [3, 4],
	3: [5, 6],
	4: [7, 8],
	5: [9, 0],
	6: [11, 12]
}

var game_paused = false

func calc_class():
	if playerClass == 1: #strong melee
		updated_stats["Health"] *= 2
		updated_stats["MeleeDamage"] *= 2
		updated_stats["Speed"] /= 2
	elif playerClass == 2:  #fast melee
		updated_stats["Health"] /= 2
		updated_stats["Speed"] *= 2
		updated_stats["MeleeSpeed"] /= 2
	elif playerClass == 3: # strong ranged
		updated_stats["Health"] *= 2
		updated_stats["Speed"] /= 2
		updated_stats["RangeDamage"] *= 2
	elif playerClass == 4: #fast ranged
		updated_stats["Speed"] *= 2
		updated_stats["Health"] /= 2
		updated_stats["RangeSpeed"] /= 2
	elif playerClass == 5: #all around fast
		updated_stats["MeleeSpeed"] /= 2
		updated_stats["RangeSpeed"] /= 2
		updated_stats["Health"] /= 2
		updated_stats["Speed"] /= 2
	elif playerClass == 6:
		updated_stats["Health"] *= 2
		updated_stats["Speed"] *= 2
		updated_stats["MeleeSpeed"] *= 2
		updated_stats["RangeSpeed"] *= 2
	
	if playerClass < 1 or playerClass > 6:
		print("Class is Unknown")
	else:
		print("I am class " + str(playerClass))
		print(updated_stats)

func calc_items():
	for item in littleGuyItems[playerClass]:
		if item == 1:
			updated_stats["Health"] += 7
		elif item == 2:
			updated_stats["MeleeDamage"] += 3
		elif item == 3:
			updated_stats["RangeDamage"] += 4
		elif item == 4:
			updated_stats["Speed"] += 0.5
		elif item == 5:
			updated_stats["MeleeSpeed"] -= 0.05
		elif item == 6:
			updated_stats["RangeSpeed"] -= 0.1

	print(updated_stats)

func calc_stats_final():
	updated_stats = base_stats.duplicate()
	calc_class()
	calc_items()
