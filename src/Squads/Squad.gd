extends Node

class_name Squad

var rng_position = RandomNumberGenerator.new()
var rng_frame = RandomNumberGenerator.new()
var Soldier = preload("res://src/Soldiers/Soldier.tscn")

var dict_soldiers : Dictionary
var dict_squads : Dictionary
var width = 220
var height = 140

func _ready():
	pass

func get_class(): return "Squad"

func Initialize_Squad(id_squad:String):
	Data_From_JSON()
	
	var SquadFetched= dict_squads.get(id_squad).get("Infantry")
	for key in SquadFetched[0]:
		#print(SquadFetched[0].get(key))
		Place_Soldier(SquadFetched[0].get(key))

func Place_Soldier(id_Soldier:String):
	var SoldierFetched = dict_soldiers.get(id_Soldier)
	var inst_Soldier = Soldier.instance()
	inst_Soldier.Initialize_Soldier(SoldierFetched)
	rng_position.randomize()
	var rand_x = rng_position.randi_range(-(width/2),(width/2))
	var rand_y = rng_position.randi_range(-(height/2),(height/2))
	#Algo to avoid sprite close to each other in a squad
	for j in $YSort.get_children():
		while(abs(j.global_position.x - rand_x) <= 15 and abs(j.global_position.y - rand_y) <= 40 ): #x15 y40
			rand_x = rng_position.randi_range(-(width/2),(width/2))
			rand_y = rng_position.randi_range(-(height/2),(height/2))
	inst_Soldier.global_position=Vector2(rand_x,rand_y)
	$YSort.add_child(inst_Soldier)

func AllFire():
	for o in $YSort.get_children():
		o.OpenFire()

func Data_From_JSON():
	var fileSoldiers = File.new()
	var fileSquads = File.new()
	var ErrSoldFile = fileSoldiers.open("res://src/Data/Soldiers.json", fileSoldiers.READ)
	var ErrSquadFile = fileSquads.open("res://src/Data/Squads.json", fileSquads.READ)
	var Soldiersjson = fileSoldiers.get_as_text()
	var Squadsjson = fileSquads.get_as_text()
	dict_soldiers  = JSON.parse(Soldiersjson).result
	dict_squads  = JSON.parse(Squadsjson).result
	fileSoldiers.close()
	fileSquads.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
