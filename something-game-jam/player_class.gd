extends Node

#Base Stats that get manipulated later
var base_stats = {
	"Health": 20,
	"MeleeDamage": 4,
	"RangeDamage": 1,
	"Speed": 4,
	"MeleeSpeed": 0.25,
	"RangeSpeed": 0.2,
}

#The updated stats that gets used in game
var updated_stats = {}

#THE CLASS THE PLAYER CHOOSES TO PLAY AS DURING ENCOUNTER
var playerClass = 0

#THE CURRENT NUMBER OF COINS THE PLAYER HAS
var coins = 0

#GLOBAL STORAGE FOR ITEMS FOR EACH LITTLE GUY
var littleGuys = {
	1: {
		owned = true,
		alive = true,
		items = [],
	},
	2: {
		owned = true,
		alive = true,
		items = [],
	},
	3: {
		owned = false,
		alive = true,
		items = [],
	},
	4: {
		owned = false,
		alive = true,
		items = [],
	},
	5: {
		owned = false,
		alive = true,
		items = [],
	},
	6: {
		owned = false,
		alive = true,
		items = [],
	},
}

var num_guys = 2
var num_alive_guys = 2


var game_paused = false


var num_enemies
var numberOfRounds
var map

var levels_beaten = 0



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
	if not littleGuys[playerClass]["owned"]:
		print("No Items")
		return
	
	for item in littleGuys[playerClass]["items"]:
		if item == 1: #Winged Boots
			updated_stats["Speed"] += 2
			updated_stats["MeleeSpeed"] -= 0.05
			updated_stats["RangeSpeed"] -= 0.05
		elif item == 2: #Shield
			updated_stats["Health"] += 20
		elif item == 3: #Axe
			updated_stats["MeleeDamage"] += 3
		elif item == 4: #Dual Blades
			updated_stats["Speed"] *= 1.5
			updated_stats["MeleeSpeed"] /= 2
		elif item == 5: #Guns
			updated_stats["RangeDamage"] += 2
			updated_stats["RangeSpeed"] /= 2

	print(updated_stats)

func calc_stats_final():
	updated_stats = base_stats.duplicate()
	calc_items()
	calc_class()
	

func reset():
	updated_stats = {}
	playerClass = 1
	coins = 0
	littleGuys = {
		1: {
			owned = true,
			alive = true,
			items = [],
		},
		2: {
			owned = true,
			alive = true,
			items = [],
		},
		3: {
			owned = false,
			alive = true,
			items = [],
		},
		4: {
			owned = false,
			alive = true,
			items = [],
		},
		5: {
			owned = false,
			alive = true,
			items = [],
		},
		6: {
			owned = false,
			alive = true,
			items = [],
		},
	}
	
	num_guys = 2
	num_alive_guys = 2


	game_paused = false


	num_enemies
	numberOfRounds
	map

	levels_beaten = 0
	
	calc_stats_final()

func revive_guys():
	for i in range(1, 7):
		if not littleGuys[i]['alive']:
			littleGuys[i]['alive'] = true
