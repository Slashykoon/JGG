extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inst_Squad_standard 
var inst_Squad_standard2
var inst_grass

var Squad_standard = preload("res://src/Squads/Squad.tscn")
var Grass = preload("res://src/Ground/Grass.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():

	
	inst_Squad_standard = Squad_standard.instance()
	inst_Squad_standard.global_position=Vector2(150,150)
	inst_Squad_standard.Initialize_Squad("USMC_Inf_43")
	get_node("YSort").add_child(inst_Squad_standard)
	
	inst_Squad_standard2 = Squad_standard.instance()
	inst_Squad_standard2.global_position=Vector2(150,500)
	inst_Squad_standard2.Initialize_Squad("USMC_Ass_43")
	get_node("YSort").add_child(inst_Squad_standard2)
	
	inst_Squad_standard2 = Squad_standard.instance()
	inst_Squad_standard2.global_position=Vector2(500,500)
	inst_Squad_standard2.Initialize_Squad("USMC_Ass_43")
	get_node("YSort").add_child(inst_Squad_standard2)
	
	Generate_grass()
	


	
	
func Generate_grass():
	var rng_grass = RandomNumberGenerator.new()
	print(get_parent().size)
	
	for i in range(100):
		rng_grass.randomize()
		inst_grass = Grass.instance()
		inst_grass.global_position=Vector2(rng_grass.randf_range(0.0,get_parent().size.x),rng_grass.randf_range(0.0,get_parent().size.y))
		get_node("YSort").add_child(inst_grass)
	for i in range(60):
		rng_grass.randomize()
		inst_grass = Grass.instance()
		inst_grass.global_position=Vector2(rng_grass.randf_range(0.0,get_parent().size.x),rng_grass.randf_range(0.0,get_parent().size.y))
		inst_grass.frame=1
		get_node("YSort").add_child(inst_grass)
	for i in range(40):
		rng_grass.randomize()
		inst_grass = Grass.instance()
		inst_grass.global_position=Vector2(rng_grass.randf_range(0.0,get_parent().size.x),rng_grass.randf_range(0.0,get_parent().size.y))
		inst_grass.frame=2
		get_node("YSort").add_child(inst_grass)
	for i in range(50):
		rng_grass.randomize()
		inst_grass = Grass.instance()
		inst_grass.global_position=Vector2(rng_grass.randf_range(0.0,get_parent().size.x),rng_grass.randf_range(0.0,get_parent().size.y))
		inst_grass.frame=3
		get_node("YSort").add_child(inst_grass)
		
		
func _input(event):
   # Mouse in viewport coordinates.
   if event is InputEventMouseButton:
	   print("Mouse Click/Unclick at: ", event.position)
   #elif event is InputEventMouseMotion:
	#   print("Mouse Motion at: ", event.position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	pass
